class AddRoleIdToUsers < ActiveRecord::Migration
  def change
    add_reference :users, :role
  end
end
