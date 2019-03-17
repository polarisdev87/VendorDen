class RenameNameToBusinessName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :vendors, :name, :business_name
  end
end
