class AddShopifyIdColumnToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column :products, :shopify_id, :string
  end
end
