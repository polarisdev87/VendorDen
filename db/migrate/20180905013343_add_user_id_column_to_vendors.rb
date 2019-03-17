class AddUserIdColumnToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :user_id, :int
  end
end
