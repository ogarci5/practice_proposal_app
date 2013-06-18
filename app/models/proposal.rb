# == Schema Information
#
# Table name: proposals
#
#  id            :integer          not null, primary key
#  name          :string(255)
#  description   :text
#  from          :string(255)
#  user_id       :integer
#  response      :text
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  response_read :boolean          default(FALSE)
#  reviewed      :boolean          default(FALSE)
#

class Proposal < ActiveRecord::Base
  belongs_to :user
  attr_accessible :response, :description, :from, :name, :user_id, :response_read , :reviewed
  
  validates :name, presence: true, length: { minimum: 3, maximum: 40}
  validates :user_id, presence: true, numericality: { only_integer: true }
  
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
