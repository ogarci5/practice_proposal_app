# == Schema Information
#
# Table name: proposals
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  description :text
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Proposal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :description, :name
  
  validates :name, presence: true, length: { minimum: 3, maximum: 40}
  validates :user_id, presence: true, numericality: { only_integer: true }
  validates :description, presence: true, length: { minimum: 6 }
  
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
    return response.body
  end
  def read
    response = self.response
    return response.read
  end
end
