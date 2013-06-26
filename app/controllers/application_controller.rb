class ApplicationController < ActionController::Base
  protect_from_forgery
  
  include SessionsHelper

  # Force signout to prevent CSRF attacks
  def verified_request?
    if request.content_type == "application/json"
      true
    else
      super()
    end
  end
  
  before_filter :require_login

  #unless Rails.application.config.consider_all_requests_local
    rescue_from Exception,
              :with => :render_error
    rescue_from ActiveRecord::RecordNotFound,
              :with => :render_not_found
    rescue_from ActionController::RoutingError,
              :with => :render_not_found
    rescue_from ActionController::UnknownController,
              :with => :render_not_found
    rescue_from AbstractController::ActionNotFound,
              :with => :render_not_found
  #end
  
  def render_not_found(exception)
    render :template => "/errors/404.html.erb",
       :layout => 'errors.html.erb'
  end

  def render_error(exception)
    ExceptionNotifier::Notifier
      .exception_notification(request.env, exception)
      .deliver
    require 'rubygems'
    require 'twilio-ruby'

    @account_sid = 'AC1b598d104e9bf5b1d2fd66ff9eb2c30e'
    @auth_token = 'b33b4168ebda69e85cdd08521abac94f'
    @body = exception.backtrace.reject {|e| not e.include? "#{Rails.root}"}
    n = @body.size - 1
    for i in 0..n
      @body[i] = @body[i].sub("#{Rails.root}", "")
    end
    @body = @body.join("\n")
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@account_sid, @auth_token)
    @account = @client.account
    @message = @account.sms.messages.create({from: '+12105260385', to: '+12103320319', body: @body})
    puts @message
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
