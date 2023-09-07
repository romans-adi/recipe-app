class User < ApplicationRecord
  has_many :foods, foreign_key: :user_id, dependent: :destroy
  has_many :recipes, foreign_key: :user_id, dependent: :destroy
  has_many :recipe_foods, foreign_key: :user_id, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true
  validates :email, uniqueness: { message: 'This email address is already in use.' }

  def admin?
    role == 'admin'
  end

  def general_shopping_list(recipe_foods)
    shopping_list = {}
    total_price = 0

    recipe_foods.each do |rf|
      food_id = rf[:food_id]
      quantity = rf[:quantity]

      if shopping_list[food_id]
        shopping_list[food_id][:quantity] += quantity
      else
        food = Food.find(food_id)
        shopping_list[food_id] = {
          name: food.name,
          quantity:,
          price: food.price
        }
      end

      total_price += quantity * shopping_list[food_id][:price]
    end

    [shopping_list.values, total_price]
  end
end
