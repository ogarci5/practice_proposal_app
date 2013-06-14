class ResponsesController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  respond_to :html, :json
  include ProposalsHelper
  
  def api_response
    require 'net/http'
    puts params
    @proposal = Proposal.find(params[:id])
    authenticated = !User.find_by_remember_token(params[:authenticity_token]).nil?
    @user = User.find_by_name(@proposal.from)
    if authenticated
      @proposal.update_attributes(response: params[:response])
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
