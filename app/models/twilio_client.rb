class TwilioClient

  def self.get_client
    @client ||= new_client
  end
  
  def self.new_client
    client = Twilio::REST::Client.new TwilioConfig.sid, TwilioConfig.auth_token
  end

  # @client.account.sms.messages.create(
  # :from => '+16502654887',
  # :to => '+16105557069',
  # :body => 'Hey there!'
  
end
