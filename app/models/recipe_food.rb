class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food

  def calculated_price
    food.price * quantity
  end
end
