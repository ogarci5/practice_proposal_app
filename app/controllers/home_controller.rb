class HomeController < ApplicationController
  def index
    @received_responses = Proposal.where(:user_id => current_user.id).find_all { |p| 
      response = p.response
      p.reviewed? && !response.read
    }.count
    @received_proposals = Proposal.all.find_all {|p| !p.reviewed? && p.to_user.id == current_user.id}.count
  end
end
