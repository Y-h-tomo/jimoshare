class Ticket < ApplicationRecord
  belongs_to :item
  belongs_to :user

  validates :number, presence: true, format: { with: /\A[0-9]+\z/ }, numericality: { greater_than: 100_000, less_than: 999_999 }
end
