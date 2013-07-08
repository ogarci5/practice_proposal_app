class CreateApprovals < ActiveRecord::Migration
  def change
    create_table :approvals do |t|
      t.string :name
      t.string :status
      t.text :comment
      t.references :user

      t.timestamps
    end
    add_index :approvals, :user_id
  end
end
