class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable
  belongs_to_active_hash :prefecture
  has_many :items, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :user_likes, through: :likes, source: :item

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  VALID_PHONE_NUBER_REGEX = /\A0+[0-9]+0+\d{7,8}\z/.freeze
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  with_options presence: true do
    validates :nickname
    validates :password, format: { with: PASSWORD_REGEX }, on: :create, length: { minimum: 6 }, confirmation: true
    validates :adress
    validates :email, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
    validates :phone_number, format: { with: VALID_PHONE_NUBER_REGEX }
  end
  validates :prefecture_id, numericality: { other_than: 1 }

  def update_without_current_password(params, *options)
    params.delete(:current_password)

    if params[:password].blank? && params[:password_confirmation].blank?
      params.delete(:password)
      params.delete(:password_confirmation)
    end

    result = update_attributes(params, *options)
    clean_up_passwords
    result
  end
end
