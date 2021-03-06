class ResponseMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def response_email(proposal)
    
    #@user = User.find_by_name(proposal.name)
    @proposal = proposal
    @url = "http://practice_proposal.com"
    @time = proposal.updated_at.strftime("%m/%d/%Y at %I:%M%p")
    mail(:to => @proposal.from_user.email, :subject => "Welcome to Practice Proposal") 
  end
end
