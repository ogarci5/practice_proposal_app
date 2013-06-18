class RemoveFromFromProposal < ActiveRecord::Migration
  def up
    remove_column :proposals, :response
    remove_column :proposals, :response_read
    remove_column :proposals, :reviewed
    remove_column :proposals, :from
  end

  def down
    add_column :proposals, :response, :string
    add_column :proposals, :response_read, :boolean, default: false
    add_column :proposals, :reviewed, :boolean, default: false
    add_column :proposals, :from, :string
  end
end
