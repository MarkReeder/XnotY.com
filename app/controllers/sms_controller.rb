class SmsController < ApplicationController
  respond_to :xml
  
  def record
    logger.info("params: " + params.inspect)
    
    @suggestion_message =
      SuggestionMessage.where(from_number: params["From"], 
                              to_number: params["To"]).first
    if @suggestion_message.nil?
      # just bail out, probably noise from a dev sandbox
      return
    end

    vote = nil
    body = params["Body"]
    if body =~ /^\w*y.*/i
      vote = "for"
    elsif body =~ /^\w*n.*/i
      vote = "against"
    else
      vote = "neutral"
    end
    @suggestion_message.has_responded = true
    @suggestion_message.save!

    @response = 
      Response.create(suggestion: @suggestion_message.suggestion,
                      user: @suggestion_message.user, 
                      vote: vote)
    # send off the next queued message if there is one.
    if !SuggestionMessage.does_user_have_messages_outstanding(@suggestion_message.user)
      next_message = SuggestionMessage.next_message(@suggestion_message.user)
      if !next_message.nil?
        next_message.send_twilio
        next_message.save!
      end
    end
    respond_with @response
  end

end
