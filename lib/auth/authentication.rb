module Authentication
  extend ActiveSupport::Concern

  class Unauthorized < StandardError; end

  included do
    helper_method :current_user, :authenticated?
    class_eval do
      def require_authentication
        authenticate current_user
      rescue Unauthorized => e
        redirect_to root_url and return false
      end
      
      def authenticate(user)
        raise Unauthorized unless user
        session[:current_user_id] = user.id
      end
      
      def unauthenticate
        @current_user = session[:current_user_id] = nil
      end
    end
  end

  def current_user
    if session[:current_user_id].blank?
      @current_user
    else
      @current_user ||= User.find(session[:current_user_id])
    end
  end
  
  def authenticated?
    !current_user.blank?
  end

  # add this alias for now, in the future, maybe we move completely over
  # to #signed_in?
  def signed_in?
    authenticated?
  end

end
