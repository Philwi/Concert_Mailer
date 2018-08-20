class AddAdminFieldToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :admin, :boolean, default: false
    add_column :users, :active, :boolean, default: false
    User.all.update_all admin: false
    User.all.update_all active: false
  end
end
