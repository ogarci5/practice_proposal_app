class AddRequesterIdToApproval < ActiveRecord::Migration
  def change
    add_column :approvals, :requester_id, :integer
  end
end
