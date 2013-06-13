module ProposalsHelper
  
  def unread_response?(proposal)
    return proposal.reviewed==true && proposal.response_read==false
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
