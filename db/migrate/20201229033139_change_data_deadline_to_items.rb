class ChangeDataDeadlineToItems < ActiveRecord::Migration[6.0]
  def change
    change_column :items, :deadline, :datetime
    change_column :items, :limit, :datetime
  end
end
