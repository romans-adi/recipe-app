class Recipe < ApplicationRecord
  belongs_to :user
  has_many :recipe_foods, dependent: :destroy
  has_many :foods, through: :recipe_foods
  validates :name, presence: true
  validates :description, presence: true

  scope :public_recipes, -> { where(public: true).order(created_at: :desc) }

  def toggle_privacy!
    update(public: !public)
  end

  def food_quantity
    recipe_foods.sum(:quantity)
  end

  def total_price
    recipe_foods.sum { |recipe_food| recipe_food.food.price * recipe_food.quantity }
  end
end
