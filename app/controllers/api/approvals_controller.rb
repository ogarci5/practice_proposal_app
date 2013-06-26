class API::ApprovalsController < ApplicationController
  skip_before_filter  :require_login
  
  def create
    require 'net/http'
    puts params
    ag = ApprovalGroup.find(params[:approval_group_id])
    a = ag.approvals.create(params[:approval])
    a.requester = User.find_by_id(params[:requester_id])
    a.save
    render :json => params
  end
  
  after_filter :close_connection, :only => [:create]

  def close_connection 
    $stderr.puts "Response #{response.code} #{response.message}: #{response.body}"
    response.close
  end
end
