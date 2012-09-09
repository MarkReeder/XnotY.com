class SmsController < ApplicationController
  respond_with :xml
  
  def record
    logger.info("sid: #{params[:Sid]}")
    logger.info("params: " + params.inspect)
    
    sid =  params[:Sid]
    suggestion_message = SuggestionMessage.where(twilio_sid: sid).first
    response = nil
    body = params[:Body]
    if body =~ /^\w*y.*/i
      response = "for"
    elsif body =~ /^\w*n.*/i
      response = "against"
    else
      response = "neutral"
    end
    response = 
      Response.create(suggestion: suggestion_message.suggestion,
                      user: suggest_message.user, 
                      vote: response)
    
  end

end
