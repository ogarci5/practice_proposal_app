class AddApprovalGroupIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :approval_group_id, :integer
  end
end
