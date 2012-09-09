class SuggestionMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :sent_at, type: DateTime
  field :has_responded, type: Boolean, default: false
  field :has_been_sent, type: Boolean, default: false
  field :twilio_sid, type: String
  field :from_number, type: String
  field :to_number, type: String
  
  belongs_to :suggestion
  belongs_to :user
  

  def self.send_message(user, suggestion)
    message = self.create(user: user, suggestion: suggestion, sent_at: Time.now)
    if !does_user_have_messages_outstanding(user)
      message.send_twilio
      message.save
    end
  end

  def self.does_user_have_messages_outstanding(user)
    num_outstanding = SuggestionMessage.where(user_id: user._id, to_number: user.cell_number,
                                              has_been_sent: true, has_responded: false).count
    num_outstanding > 0
  end

  def self.next_message(user)
    where(user: user, to_number: user.cell_number,
          has_been_sent: false).first
  end

  def send_twilio
    response =
      TwilioClient.get_client.account.sms.messages.
      create(from: TwilioConfig.xnoty_number, to: user.cell_number,
             body: "New suggestion from #{suggestion.user.easy_name}\n" +
             "#{suggestion.description}.\nSound good? Reply:\n(y)es, (n)o, (m)maybe")
    self.twilio_sid = response.sid
    self.from_number = response.from
    self.to_number = response.to
  end    
  
end
