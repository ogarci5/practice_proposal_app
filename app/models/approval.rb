class Approval < ActiveRecord::Base
  belongs_to :requester, class_name: "User", foreign_key: "requester_id"
  belongs_to :approval_group
  belongs_to :request_group
  attr_accessible :comment, :name, :status
  
  def approvers
    ag = self.approval_group
    users = ag.users
    approvers = users.find_all do |user| 
      user.roles.any? do |role| 
        role.name == "Manager"
      end
    end
    return approvers
  end
  
end
