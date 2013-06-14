module ProposalsHelper
  def email_proposer(email, proposal)
    Resque.enqueue(MailGun, email, proposal)
  end
  
  def unread_response?(proposal)
    return proposal.reviewed==true && proposal.response_read==false
  end
  
  def reviewed?(proposal)
    if proposal.reviewed==true && proposal.response_read==false
      return "reviewed"
    elsif proposal.reviewed==true && proposal.response_read==true
      return "read"
    else
      return "new"
    end
  end
  
  def num_unread_responses(current_user)
  	p = (Proposal.where(from: current_user.name ).find_all{|f| f.reviewed==true && f.response_read==false}).count
  	p>0 ? "(#{p})" : ""
  end
  
  def num_unreviewed_responses(current_user)
  	p = (Proposal.where(user_id: current_user.id ).find_all{|f| f.reviewed==false}).count
  	p>0 ? "(#{p})" : ""
  end
  
end
