class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.where(:user_id => current_user.id)
  end
  def responses
    @proposals = Proposal.where(:user_id => current_user.id).find_all {|p| p.reviewed?}
  end
  def pending_responses
    @proposals = Proposal.where(:user_id => current_user.id).find_all {|p| !p.reviewed?}
  end
  def show
    @proposal = Proposal.find(params[:id])
    if @proposal.reviewed==true && @proposal.response_read==false
      @proposal.response_read = true
      @proposal.save
    end
  end
  def show_response
    @proposal = Proposal.find(params[:id])
    @proposal.response_read = true
    @proposal.save
  end
  def respond_to_proposal
    @proposal = Proposal.find(params[:id])
  end
  
  def edit
  end
  def create
    @user = User.find(params[:proposal][:user_id])
    @proposal = @user.proposals.new(name: params[:proposal][:name], 
    description: params[:proposal][:description], from: current_user.name, response: "")
    if @proposal.save
      redirect_to proposals_path
    end
  end
  def new
    @proposal = Proposal.new
    @user = User.all
  end
  def destroy
  end
  
  def update
    message = params[:proposal].merge!(id: params[:id])
    authentication = {:authenticity_token => current_user.remember_token}
    Resque.enqueue(APIAccess, message, authentication)
    @proposal = Proposal.find(params[:id])
    @proposal.reviewed = true
    @proposal.save
    redirect_to respondant_path
    #@proposal.update_attributes(params[:proposal])
    #if @proposal.update_attributes(params[:proposal])
    #  authentication = {:authenticity_token => current_user.remember_token}
    #  Resque.enqueue(MyJob, params[:proposal], authentication)
    #end
  end
end
