class AddResponseReadToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :response_read, :boolean, :default => false 
  end
end
