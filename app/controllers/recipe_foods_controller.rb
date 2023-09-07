class RecipeFoodsController < ApplicationController
  def new
    @recipe = Recipe.find(params[:recipe_id])
    @available_foods = Food.all
    @recipe_food = RecipeFood.new
  end

  def create
    @recipe = Recipe.find(params[:recipe_id])
    @food = Food.find(params[:recipe_food][:food_id])
    quantity = params[:recipe_food][:quantity].to_i

    if quantity.positive?
      @recipe_food = RecipeFood.new(recipe_id: @recipe.id, food_id: @food.id, quantity: quantity)
      if @recipe_food.save
        @food.update(quantity: @food.quantity + quantity)
        redirect_to recipe_path(@recipe.id)
      else
        render :new
      end
    else
      flash[:alert] = 'Quantity must be a positive number.'
      render :new
    end
  end

  def edit
    @recipe = Recipe.find(params[:recipe_id])
    @recipe_food = RecipeFood.find(params[:id])
  end

  def update
    @recipe_food = RecipeFood.find(params[:id])
    old_quantity = @recipe_food.quantity
    new_quantity = params[:recipe_food][:quantity].to_i
    quantity_diff = new_quantity - old_quantity
    if @recipe_food.update(quantity: new_quantity)
      food = @recipe_food.food
      if food.quantity <= 0
        food.destroy
        flash[:notice] = 'Food item is depleted and has been removed from the list.'
        redirect_to recipe_path(params[:recipe_id])
      else
        food.update(quantity: food.quantity - quantity_diff)
        redirect_to recipe_path(params[:recipe_id]), notice: 'Your quantity updated successfully'
      end
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
