class User < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:facebook, :google_oauth2]
  belongs_to_active_hash :prefecture
  has_many :items, dependent: :destroy
  has_many :tickets, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorite_items, through: :favorites, source: :item
  has_many :comments, dependent: :destroy
  has_many :likes
  has_many :user_likes, through: :likes, source: :item
  has_many :sns_credentials

  PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]+\z/i.freeze
  VALID_PHONE_NUBER_REGEX = /\A0+[0-9]+0+\d{7,8}\z/.freeze

  with_options presence: true do
    validates :nickname
    validates :email, uniqueness: { case_sensitive: false }
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
  def self.from_omniauth(auth)
    sns = SnsCredential.where(provider: auth.provider, uid: auth.uid).first_or_create
       # sns認証したことがあればアソシエーションで取得
   # 無ければemailでユーザー検索して取得orビルド(保存はしない)
   user = User.where(email: auth.info.email).first_or_initialize(
    nickname: auth.info.name,
      email: auth.info.email
  )
  if user.persisted?
    sns.user = user
    sns.save
  end
  { user: user, sns: sns }
  end
end
