class StockItem
  include ActiveModel::Model
  attr_accessor :user_id, :name, :quantity, :description, :category_id, :condition_id, :deadline, :prefecture_id, :price,
                :contact_location, :stock_id, :image, :limit

  with_options presence: true do
    validates :name, length: { maximum: 40 }
    validates :quantity, numericality: { greater_than: 0, less_than: 100 }
    validates :description, length: { maximum: 200 }
    validates :deadline
    validates :price, format: { with: /\A[0-9]+\z/ }, numericality: { less_than: 1_000_000 }
    validates :contact_location
    validates :image
    validates :limit
  end
  with_options numericality: { other_than: 1 } do
    validates :prefecture_id
    validates :category_id
    validates :condition_id
  end

  def save
    stock = Stock.create(user_id: user_id, limit: limit)
    Item.create(
      name: name,
      quantity: quantity,
      description: description,
      category_id: category_id,
      condition_id: condition_id,
      deadline: deadline,
      prefecture_id: prefecture_id,
      price: price,
      contact_location: contact_location,
      image: image,
      user_id: stock.user_id,
      stock_id: stock.id
    )
  end

  def update
    stock = Stock.update(user_id: user_id, limit: limit)
    Item.update(
      name: name,
      quantity: quantity,
      description: description,
      category_id: category_id,
      condition_id: condition_id,
      deadline: deadline,
      prefecture_id: prefecture_id,
      price: price,
      contact_location: contact_location,
      image: image,
      user_id: stock.user_id,
      stock_id: stock.id
    )
  end

  # def to_model
  #   item
  # end

  # attr_reader :item
  # def default_attributes
  #   {
  #         name: item.name,
  #         quantity: item.quantity,
  #         description: item.description,
  #         category_id: item.category_id,
  #         condition_id: item.condition_id,
  #         deadline: item.deadline,
  #         prefecture_id: item.prefecture_id,
  #         price: item.price,
  #         contact_location: item.contact_location,
  #         image: item.image,
  #         stock_id: item.stock_id,
  #         user_id: item.user_id,
  #         limit: @limit
  #   }
  # end
end
