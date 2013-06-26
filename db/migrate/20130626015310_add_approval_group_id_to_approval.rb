class AddApprovalGroupIdToApproval < ActiveRecord::Migration
  def change
    add_column :approvals, :approval_group_id, :integer
  end
end
