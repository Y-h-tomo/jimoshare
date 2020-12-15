class AddColumnStockToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :stock, :string
    add_column :items, :limit, :date
  end
end
