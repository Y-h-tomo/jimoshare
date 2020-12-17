class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to :user
  has_one_attached :image
  has_many :tickets, dependent: :destroy

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :quantity, numericality: { greater_than: -1, less_than: 100 }
    validates :description, length: { maximum: 200 }
    validates :deadline
    validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { less_than: 1_000_000 }
    validates :contact_location
    validates :image
  end
  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :category_id
    validates :condition_id
  end

  validate :date_before_start
  def date_before_start
    return if deadline.blank?

    errors.add(:deadline, 'は今日以降のものを選択してください') if deadline < Date.today
  end

  def self.sort(selection)
    case selection
    when 'new'
      all.order(created_at: :DESC)
    when 'many'
      all.order(quantity: :DESC)
    when 'price'
      all.order(price: :ASC)
    when 'limit'
      all.order(deadline: :ASC)
    end
  end
end
