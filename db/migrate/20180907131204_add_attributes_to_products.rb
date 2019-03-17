class AddAttributesToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :description, :string
  	add_column :products, :minimum_commission_per_product, :decimal
  	add_column :products, :commission_structure_type, :string
  end
end
