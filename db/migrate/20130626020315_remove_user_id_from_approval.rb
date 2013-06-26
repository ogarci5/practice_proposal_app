class RemoveUserIdFromApproval < ActiveRecord::Migration
  def up
    remove_column :approvals, :user_id
  end

  def down
    add_column :approvals, :user_id, :integer
  end
end
