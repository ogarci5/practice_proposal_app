class ApprovalGroup < ActiveRecord::Base
  attr_accessible :name
  has_many :approvals
  has_many :users
end
