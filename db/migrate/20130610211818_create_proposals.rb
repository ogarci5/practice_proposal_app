class CreateProposals < ActiveRecord::Migration
  def change
    create_table :proposals do |t|
      t.string :name
      t.text :description
      t.string :from
      t.references :user
      t.text :response

      t.timestamps
    end
    add_index :proposals, :user_id
  end
end
