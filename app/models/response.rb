class Response < ActiveRecord::Base
  belongs_to :proposal
  belongs_to :user
  attr_accessible :body, :read, :user_id, :proposal_id
end
