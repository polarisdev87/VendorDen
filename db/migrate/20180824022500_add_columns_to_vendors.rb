class AddColumnsToVendors < ActiveRecord::Migration[5.2]
  def change
    add_column :vendors, :poc_first_name, :string
    add_column :vendors, :poc_last_name, :string
    add_column :vendors, :phone_number, :string
    add_column :vendors, :tax_id, :string
    add_column :vendors, :address, :text
  end
end
