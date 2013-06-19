class ApplicationController < ActionController::Base
  protect_from_forgery :except => :response
  
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  before_filter :require_login

  private

    def require_login
      unless current_user
        redirect_to login_path
      end
    end
end