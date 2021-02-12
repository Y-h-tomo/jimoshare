class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  belongs_to_active_hash :category
  belongs_to_active_hash :condition
  belongs_to :user
  has_one_attached :image
  has_many :tickets
  has_many :likes, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy

  NGWORD_REGEX = /(.)\1{4,}/.freeze

  with_options presence: true do
    validates :name, length: { maximum: 40 }, format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' },
                     obscenity: { message: 'はNGワードになっています' }
    validates :quantity, numericality: { greater_than: -1, less_than: 100 }
    validates :description, length: { maximum: 200 },
                            format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' },
                            obscenity: { sanitize: true }
    validates :deadline
    validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { less_than: 1_000_000 }
    validates :contact_location,
              format: { without: NGWORD_REGEX, message: 'は5文字以上の繰り返しは禁止です' },
              obscenity: { sanitize: true }
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

  def favorites_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def likes_by?(user)
    likes.where(user_id: user.id).exists?
  end
  ransacker :likes_count do
    query = '(SELECT COUNT(likes.item_id) FROM likes where likes.item_id = items.id GROUP BY likes.item_id)'
    Arel.sql(query)
  end
end
