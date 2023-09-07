class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def calculated_price
    food.price * quantity
  end
end
