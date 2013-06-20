class ResponsesController < ApplicationController
  def index
    @received = Proposal.where(:user_id => current_user.id).find_all {|p| p.reviewed? && p.response}
    @sent = Proposal.all.find_all {|p| p.reviewed? && p.to_user.id == current_user.id}
  end
  #def show
  #  @response = Response.find(params[:id])
  #  @proposal = @response.proposal
  #end
  def update
    message = params[:response].merge!(id: params[:id])
    authentication = {:authenticity_token => current_user.remember_token}
    Resque.enqueue(APIAccess, message, authentication)
    redirect_to responses_path+"?sent=true"
  end
  def edit
    @response = Response.find(params[:id])
    @proposal = @response.proposal
  end
end
