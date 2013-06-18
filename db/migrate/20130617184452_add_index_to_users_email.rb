class AddIndexToUsersEmail < ActiveRecord::Migration
  
  # this forces uniqueness of :email at the db level
  def change
    add_index :users, :email, unique: true
  end
end
