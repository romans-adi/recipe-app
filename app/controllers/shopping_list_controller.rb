class ShoppingListController < ApplicationController
  def index
    @current_user = current_user
    @recipe = Recipe.find_by(id: params[:recipe_id])
  end
end
