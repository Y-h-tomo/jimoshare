class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  belongs_to_active_hash :prefecture
  has_many :items
  has_many :tickets

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  VALID_PHONE_NUBER_REGEX = /\A0+[0-9]+0+\d{7,8}\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: { case_sensitive: false }
    validates :password, format: { with: PASSWORD_REGEX }
    validates :phone_number, format: { with: VALID_PHONE_NUBER_REGEX }
  end
  validates :prefecture_id, numericality: { other_than: 1 }
end
