class SmsController < ApplicationController
  respond_to :xml
  
  def record
    logger.info("sid: #{params[:Sid]}")
    logger.info("params: " + params.inspect)
    
    sid =  params[:Sid]
    @suggestion_message = SuggestionMessage.where(twilio_sid: sid).first
    vote = nil
    body = params[:Body]
    if body =~ /^\w*y.*/i
      vote = "for"
    elsif body =~ /^\w*n.*/i
      vote = "against"
    else
      vote = "neutral"
    end
    @response = 
      Response.create(suggestion: @suggestion_message.suggestion,
                      user: @suggest_message.user, 
                      vote: vote)
    respond_with @response
  end

end
