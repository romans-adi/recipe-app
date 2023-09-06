class ShoppingListController < ApplicationController
  def index
    @current_user = current_user
    @recipe = Recipe.find_by(id: params[:recipe_id])
    @foods = current_user.recipe_foods.includes(food: :user).map(&:food).uniq
    @total_price = @foods.map { |ingredient| ingredient.price * ingredient.total_quantity_recipes }.sum
  end
end
