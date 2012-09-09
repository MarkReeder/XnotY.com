class ApplicationController < ActionController::Base
  inlcude Authentication
  protect_from_forgery
  before_filter :require_authentication
  before_filter :set_current_user

  def set_current_user
    authenticated?
    if @current_user.nil?
      redirect_to root_url
    end
  end

end
