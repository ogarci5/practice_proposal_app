class ErrorsController < ApplicationController
  
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
