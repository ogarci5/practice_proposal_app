class CreateRequestGroups < ActiveRecord::Migration
  def change
    create_table :request_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
