# == Schema Information
#
# Table name: responses
#
#  id          :integer          not null, primary key
#  body        :text
#  proposal_id :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  read        :boolean          default(FALSE)
#

class Response < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  attr_accessible :body, :read, :user_id, :proposal_id
end
