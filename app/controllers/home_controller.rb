class HomeController < ApplicationController
  skip_before_filter :require_login
  def index
    if current_user
    @received_responses = Proposal.where(:user_id => current_user.id).find_all { |p| 
      response = p.response
      p.reviewed? && !response.read
    }.count
    @received_proposals = Proposal.all.find_all {|p| !p.reviewed? && p.to_user.id == current_user.id}.count
    end
  end
end
