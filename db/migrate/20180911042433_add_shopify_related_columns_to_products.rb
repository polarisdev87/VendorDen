class AddShopifyRelatedColumnsToProducts < ActiveRecord::Migration[5.2]
  def change
    add_column    :products, :title, :string, nil: false
    add_column    :products, :shopify_variant_id, :string
    add_column    :products, :price,     :decimal, nil: false
    add_column    :products, :body_html, :text
    
    remove_column :products, :description
  end
end
