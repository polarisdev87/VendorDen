class AddStocksAvailableToProducts < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :stocks_available, :integer
  end
end
