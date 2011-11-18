module Authentication

  class Unauthorized < StandardError; end

  def self.included(base)
    base.send(:include, Authentication::HelperMethods)
    base.send(:include, Authentication::ControllerMethods)
  end

  module HelperMethods

    def current_user
      @current_user ||= Facebook.find(session[:current_user])
    rescue ActiveRecord::RecordNotFound
      nil
    end

    def friends_on_app
      friends = []
      current_user.profile.friends.each do |friend|
        friends << friend.identifier
      end
      @friends_on_app = Facebook.find_by_identifier(friends)
    end

    def authenticated?
      !current_user.blank?
    end

  end

  module ControllerMethods

    def require_authentication
      authenticate Facebook.find_by_id(session[:current_user])
    rescue Unauthorized => e
      redirect_to root_url and return false
    end

    def authenticate(user)
      raise Unauthorized unless user
      session[:current_user] = user.id
    end

    def unauthenticate
      current_user.destroy
      @current_user = session[:current_user] = nil
    end

  end

end