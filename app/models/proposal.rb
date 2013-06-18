class Proposal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name
  
  # Have Proposal.all be ordered by default
  default_scope order('created_at DESC')
  has_one :response
  def from_user
    return self.user
  end
  def to_user
    response = self.response
    return response.user
  end
  def reviewed?
    response = self.response
    return !response.body.blank?
  end
  def response_body
    response = self.response
    return !response.body
  end
  def read
    response = self.response
    return response.read
  end
end
