class AddRequestGroupIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :request_group_id, :integer
  end
end
