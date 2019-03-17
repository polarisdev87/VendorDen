class AddIsBookableColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :is_bookable, :boolean, default: false
  end
end
