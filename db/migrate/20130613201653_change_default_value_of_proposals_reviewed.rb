class ChangeDefaultValueOfProposalsReviewed < ActiveRecord::Migration
  def up
      change_column :proposals, :reviewed, :boolean, :default => false
  end

  def down
  end
end
