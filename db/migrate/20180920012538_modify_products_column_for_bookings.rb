class ModifyProductsColumnForBookings < ActiveRecord::Migration[5.2]
  def up
    remove_column :products, :price
    remove_column :products, :body_html
    remove_column :products, :shopify_variant_id
    add_column :products, :cost_of_goods, :decimal
  end
end
