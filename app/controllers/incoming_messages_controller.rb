class IncomingMessagesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  skip_before_filter :require_login
  def create
    puts params[:message]
    #for recipient in message.to
    #  #User.find_by_email(recipient).update_attribute(:bio, message.body)
    #  puts message
    #end
    #respond_to do |format|
    #  format.html { render template: 'errors/404.html.erb', layout: 'layouts/errors', status: 404 }
    #  format.all { render nothing: true, status: 404 }
    #end
  end
end
