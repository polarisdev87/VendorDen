class AddAdminUserIdColumnToShops < ActiveRecord::Migration[5.2]
  def change
    add_column :shops, :admin_user_id, :integer
  end
end
