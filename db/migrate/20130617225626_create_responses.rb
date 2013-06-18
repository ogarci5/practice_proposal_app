class CreateResponses < ActiveRecord::Migration
  def change
    create_table :responses do |t|
      t.text :body
      t.references :proposal
      t.references :user

      t.timestamps
    end
    add_index :responses, :proposal_id
    add_index :responses, :user_id
  end
end
