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
    #ExceptionNotifier::Notifier
    #  .exception_notification(request.env, exception)
    #  .deliver
    require 'rubygems'
    require 'twilio-ruby'
    
    @og_account_sid = 'AC1b598d104e9bf5b1d2fd66ff9eb2c30e'
    @og_auth_token = 'b33b4168ebda69e85cdd08521abac94f'
    
    @body = exception.backtrace.reject {|e| not e.include? "#{Rails.root}"}
    n = @body.size - 1
    for i in 0..n
      @body[i] = @body[i].sub("#{Rails.root}", "")
    end
    @body = @body.join("\n")
    # set up a client to talk to the Twilio REST API
    @client = Twilio::REST::Client.new(@og_account_sid, @og_auth_token)
    @account = @client.account
    #@message = @account.sms.messages.create({from: '+12105260385', to: '+12103320319', body: @body})
    puts @message
    render :template => "/errors/500.html.erb",
       :layout => 'errors.html.erb'
  end
  
  def response_sms(response)
    
    require 'rubygems'
    require 'twilio-ruby'
    
    # personal Twilio info
    @cd_account_sid   = 'AC8d4c38961360b8c7de1e43d84e299429'
    @cd_auth_token    = '55ed18b301a21c7205c1237276ec8264'
    @cd_phone         = '+15166707115'
    @cd_twil_phone    = '+15165379735'
    
    # get response info
    @name     = response.proposal.name
    @to       = User.find(response.user_id).name
    @from     = User.find(response.proposal.user.id).name
    @body     = response.body
    
    # message body
    
    @message  = "Proposal: #{@name}\n"\
                "To: #{@to}\n"\
                "From: #{@from}\n"\
                "Response: #{@body}"
    
    @message = "New message: http://proposalapp.com/proposals/#{response.proposal.id}"
    
    # set up a client to talk to the Twilio REST API
    # and send text
    @client           = Twilio::REST::Client.new(@cd_account_sid, @cd_auth_token)
    @account          = @client.account
    @message1          = @account.sms.messages.create({from: @cd_twil_phone,
                        to: @cd_phone, body: @message})
    puts "Sent response SMS to #{@cd_phone}: #{@message}"
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
