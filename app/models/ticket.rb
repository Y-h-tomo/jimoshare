class Ticket < ApplicationRecord
  belongs_to :item,dependent: :destroy

end