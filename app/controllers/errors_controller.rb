class ErrorsController < ApplicationController
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
end
