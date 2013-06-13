class ProposalsController < ApplicationController
  def index
    @proposals = Proposal.where(:user_id => current_user.id).find_all {|p| !p.responded?}
  end
  def show
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
    @proposal = Proposal.find(params[:id])
    message = params[:proposal].merge!(id: params[:id])
    authentication = {:authenticity_token => current_user.remember_token}
    Resque.enqueue(MyJob, message, authentication)
    redirect_to proposals_path
    #@proposal.update_attributes(params[:proposal])
    #if @proposal.update_attributes(params[:proposal])
    #  authentication = {:authenticity_token => current_user.remember_token}
    #  Resque.enqueue(MyJob, params[:proposal], authentication)
      
      #end
  end
end
