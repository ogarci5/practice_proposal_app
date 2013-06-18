class ResponsesController < ApplicationController
  def index
    @received = Proposal.where(:user_id => current_user.id).find_all {|p| p.reviewed? && p.response}
    @sent = Proposal.all.find_all {|p| p.reviewed? && p.to_user.id == current_user.id}
  end
  def show
    @response = Response.find(params[:id])
    @proposal = @reponse.proposal
  end
  def update
    @response = Response.find(params[:id])
    if @response.update_attributes(params[:response])
      redirect_to responses_path+"?sent=true"
    end
  end
  def edit
    @response = Response.find(params[:id])
    @proposal = @response.proposal
  end
end
