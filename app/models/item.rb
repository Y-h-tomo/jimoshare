class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :quantity, numericality: { greater_than: 0, less_than: 100 }
    validates :description, length: { maximum: 200 }
    validates :deadline
    validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { less_than: 1_000_000 }
    validates :contact_location
  end
  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :category_id
    validates :condition_id
  end
  validate :date_before

  def date_before
    errors.add(:deadline) if deadline < Date.today
  end
end
