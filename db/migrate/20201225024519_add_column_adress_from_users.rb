class AddColumnAdressFromUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :adress, :text, null: false
  end
end
