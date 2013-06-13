class ChangeDataTypeForProposalReviewed < ActiveRecord::Migration
  def self.up
    add_column :proposals, :convert_reviewed, :boolean, :default => true
    
        # look up the schemas to be able to re-inspect the Project model
        # http://apidock.com/rails/ActiveRecord/Base/reset_column_information/class
        Proposal.reset_column_information
    
        # loop over the collection
        Proposal.all.each do |p|
            p.convert_reviewed = p.reviewed == '1'
            p.save
        end
    
        # remove the older reviewed column
        remove_column :proposals, :reviewed
        # rename the convert_reviewed to reviewed column
        rename_column :proposals,:convert_reviewed,:reviewed
  end
 
  def self.down
    change_table :widgets do |t|
      change_column :proposals, :reviewed, :string
    end
  end
end
