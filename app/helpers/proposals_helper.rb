module ProposalsHelper
<<<<<<< HEAD
  def email_proposer(email, proposal)
    Resque.enqueue(MailGun, email, proposal)
  end
  def unread_response?(proposal)
    return proposal.reviewed==true && proposal.response_read==false
=======
  
  def reviewed?(proposal)
    if proposal.reviewed==true && proposal.response_read==false
      return "reviewed"
    elsif proposal.reviewed==true && proposal.response_read==true
      return "read"
    else
      return "new"
    end
>>>>>>> d4cd3e6967826e25a3a5d8202b1764cbe871efdb
  end
  
  def num_unread_responses(current_user)
  	p = (Proposal.where(from: current_user.name ).find_all{|f| f.reviewed==true && f.response_read==false}).count
  	p>0 ? "(#{p})" : ""
  end
  
  def num_unreviewed_responses(current_user)
  	p = (Proposal.where(from: current_user.name ).find_all{|f| f.reviewed==false}).count
  	if p>0
  		return "(#{p})"
    else
      return ""
    end
  end
  
end
