class Proposal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :response, :description, :from, :name
  
  # Have Proposal.all be ordered by default
  default_scope order('id ASC')
  
  def to
    @user = User.find(self.user_id)
    return @user.name
  end
  
  def reviewed?
    return self.reviewed
  end
end
