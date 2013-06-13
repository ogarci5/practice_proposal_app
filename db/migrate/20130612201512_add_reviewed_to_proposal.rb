class AddReviewedToProposal < ActiveRecord::Migration
  def change
    add_column :proposals, :reviewed, :string, :default => false 
  end
end
