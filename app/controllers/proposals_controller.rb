class ProposalsController < ApplicationController
  def index
    @sent = Proposal.where(:user_id => current_user.id).find_all {|p| !p.reviewed?}
    @received = Proposal.all.find_all {|p| !p.reviewed? && p.to_user.id == current_user.id}
  end
  def show
    @proposal = Proposal.find(params[:id])
    p params
    if @proposal.reviewed? && @proposal.from_user.id == current_user.id
      response = @proposal.response
      response.read = true
      response.save
    end
  end
  def create
    @user = User.find(current_user.id)
    @proposal = @user.proposals.new(name: params[:proposal][:name], 
    description: params[:proposal][:description])
    if @proposal.save
      @response = Response.create(user_id: params[:response][:user_id], proposal_id: @proposal.id)
      @response.read = false
      @response.save
      redirect_to proposals_path
    else
      render 'new'
    end
  end
  def new
    @proposal = Proposal.new
    @user = User.all
  end
  #def update
  #  message = params[:proposal].merge!(id: params[:id])
  #  authentication = {:authenticity_token => current_user.remember_token}
  #  Resque.enqueue(APIAccess, message, authentication)
  #  redirect_to respondant_path
  #end
end
