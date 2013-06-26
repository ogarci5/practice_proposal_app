class CreateRolesUsers < ActiveRecord::Migration
  def up
    create_table :roles_users do |t|
      t.references :user
      t.references :role
    end
  end

  def down
    drop_table :roles_users
  end
end
