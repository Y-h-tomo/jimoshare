class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :quantity
    validates :description
    validates :deadline
    validates :price
    validates :contact_location
  end
  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :category_id
    validates :condition_id
  end
end
