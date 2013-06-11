class Proposal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :response, :description, :from, :name
  
  def to
    @user = User.find(self.user_id)
    return @user.name
  end
  
  def responded?
    return !self.response.blank?
  end
end
