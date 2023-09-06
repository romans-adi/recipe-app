class RecipeFoodsController < ApplicationController
  def new
    @current_user = current_user
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @available_foods = current_user.foods.reject { |f| @recipe.foods.include?(f) }
    @recipe_food = RecipeFood.new
    @recipe_food.recipe = @recipe
  end

  def create
    @recipe = Recipe.find_by_id(params[:recipe_id])
    @available_foods = current_user.foods.reject { |f| @recipe.foods.include?(f) }
    @recipe_food = RecipeFood.new(recipe_food_params.merge(recipe_id: @recipe.id, user_id: current_user.id))
    if @recipe_food.save
      food = @recipe_food.food
      food.quantity -= @recipe_food.quantity
      food.save

      redirect_to recipe_path(@recipe.id)
    else
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    if @recipe_food.update(quantity: params[:recipe_food][:quantity])
      redirect_to recipe_path(params[:recipe_id]), notice: 'Your quantity updated successfully'
    else
      flash[:alert] = 'Something went wrong, try again!'
      render :edit
    end
  end

  def destroy
    @recipe_food = RecipeFood.find_by_id(params[:id])
    if @recipe_food
      if @recipe_food.destroy
        flash[:notice] = 'Ingredient deleted.'
      else
        flash[:alert] = 'Ingredient deletion unsuccessful.'
      end
    else
      flash[:alert] = 'Ingredient not found.'
    end
    redirect_to recipe_path(params[:recipe_id])
  end

  private

  def recipe_food_params
    params.require(:recipe_food).permit(:quantity, :food_id)
  end
end
