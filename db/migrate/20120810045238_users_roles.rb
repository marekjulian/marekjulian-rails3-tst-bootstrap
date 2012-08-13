class UsersRoles < ActiveRecord::Migration
  def up
    create_table 'users_roles', :id => false do |t|
      t.column :user_id, :integer
      t.column :role_id, :integer
    end
  end

  def down
    drop_table :users_roles
  end
end
