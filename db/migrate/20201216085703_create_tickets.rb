class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.references :item, null: false
      t.references :user, null: false
      t.integer   :number, null: false
      t.timestamps
    end
  end
end
