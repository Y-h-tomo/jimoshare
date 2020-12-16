class CreateTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tickets do |t|
      t.references :item, null: false, foreign_key: true
      t.integer   :number, null: false
      t.timestamps
    end
  end
end