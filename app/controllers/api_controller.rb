class ApiController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :html, :json
  include ProposalsHelper
  
  def api_response
    require 'net/http'
    puts params
    @response = Response.find(params[:id])
    proposal = @response.proposal
    authenticated = !User.find_by_remember_token(params[:authenticity_token]).nil?
    @user = User.find(proposal.from_user.id)
    if authenticated
      @response.update_attributes(body: params[:body])
      # email_proposer(@user.email, @proposal)
    end
    respond_with(params, :status => 200)
  end
  after_filter :close_connection, :only => [:api_response]

  def close_connection 
    $stderr.puts "Response #{response.code} #{response.message}: #{response.body}"
    response.close
  end
end
