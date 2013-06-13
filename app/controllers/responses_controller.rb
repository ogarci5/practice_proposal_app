class ResponsesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :html, :json
  def api_response
    require 'net/http'
    p params
    #respond_to do |format|
    #  format.html
    #  format.json { render json: params }
    #end
    flash[:success] = "#{params} was received."
    p flash[:success]
    p response_body
    @proposal = Proposal.find(params[:id])
    @user = User.find_by_remember_token(params[:authenticity_token])
    if !@user.nil?
      @proposal.update_attributes(response: params[:response])
    end
    #render :json => params.to_json, :status => :unprocessable_entity
    respond_with(params, :status => 200)
    #close
  end
  after_filter :print_response_body, :only => [:api_response]

  def print_response_body 
    $stderr.puts response.body
    response.close
  end
end
