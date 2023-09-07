class RecipeFood < ApplicationRecord
  belongs_to :recipe
  belongs_to :food
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :quantity_must_be_positive

  def calculated_price
    food.price * quantity
  end

  private

  def quantity_must_be_positive
    return unless quantity <= 0

    errors.add(:quantity, 'must be a positive number')
  end
end
