class AddRequestGroupIdToApproval < ActiveRecord::Migration
  def change
    add_column :approvals, :request_group_id, :integer
  end
end
