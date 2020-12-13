class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :quantity,null: false
      t.text :description
      t.integer :category_id ,null: false
      t.integer :condition_id, null: false
      t.date :deadline,null: false
      t.integer :prefecture_id,    null: false
      t.integer :price,    null: false
      t.text :contact_location,  null: false
      t.timestamps
    end
  end
end
