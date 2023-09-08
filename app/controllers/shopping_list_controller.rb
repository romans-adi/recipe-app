class ShoppingListController < ApplicationController
  def index
    @recipe = Recipe.find(params[:recipe_id])
    _, sort_direction = determine_sorting(params[:sort], params[:direction])
    @recipe_foods = RecipeFood.where(recipe_id: @recipe.id)
      .includes(food: :user)
      .sort_by(&:calculated_price)
    @recipe_foods.reverse! if sort_direction == 'desc'
    @general_shopping_list, @total = current_user.general_shopping_list(@recipe_foods)
  end

  private

  def determine_sorting(sort_param, direction_param)
    column = 'name'
    direction = 'asc'
    case sort_param
    when 'food'
      column = 'food'
    when 'quantity'
      column = 'quantity'
    when 'price'
      column = 'calculated_price'
    end
    direction = direction_param if %w[asc desc].include?(direction_param)
    [column, direction]
  end
end
