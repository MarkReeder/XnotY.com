class SuggestionMessage
  include Mongoid::Document
  include Mongoid::Timestamps
  
  field :sent_at, type: DateTime
  field :has_responded, type: Boolean, default: false
  field :twilio_sid, type: String
  
  belongs_to :suggestion
  belongs_to :user
  

  def self.send(user, suggestion)
    message = self.create(user: user, suggestion: suggestion, sent_at: Time.now)
    response = 
      TwilioClient.get_client.account.sms.messages.
      create(from: TwilioConfig.xnoty_number, to: user.cell_number,
             body: "New suggestion from #{suggestion.user.easy_name}: " +
             "#{suggestion.description}.\nSound Good? reply (y)es, (n)o, (m)maybe")
    message.twilio_sid = response.sid
    message.save
  end
  
end
