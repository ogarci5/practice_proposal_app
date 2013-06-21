class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end
  before_filter :require_login

  unless Rails.application.config.consider_all_requests_local
    rescue_from Exception,
              :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,
              :with => :render_not_found
    rescue_from ActionController::RoutingError,
              :with => :render_not_found
    rescue_from ActionController::UnknownController,
              :with => :render_not_found
    rescue_from ActionController::UnknownAction,
              :with => :render_not_found
  end
  
  def render_not_found(exception)
    render :template => "/errors/404.html.erb",
       :layout => 'errors.html.erb'
  end

  def render_error(exception)
    ExceptionNotifier::Notifier
      .exception_notification(request.env, exception)
      .deliver
    render :template => "/errors/500.html.erb",
       :layout => 'errors.html.erb'
  end
  def routing_error
    render_not_found(nil)
  end
  
  private

    def require_login
      if !User.find_by_remember_token(params[:authenticity_token]).nil?
        user = User.find_by_remember_token(params[:authenticity_token])
        sign_in(user)
      end
      unless current_user
        redirect_to login_path
      end
    end

end
