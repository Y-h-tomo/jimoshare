class AddColumnStockToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :stock, :boolean, default: false
    add_column :items, :limit, :date
  end
end
