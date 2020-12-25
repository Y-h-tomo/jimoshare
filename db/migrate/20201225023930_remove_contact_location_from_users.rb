class RemoveContactLocationFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :contact_location, :text
  end
end
