class RecipesController < ApplicationController
  def my_recipes
    @user = current_user
    @recipes = @user.recipes
  end

  def show
    @recipe = Recipe.find_by(id: params[:id])
    @ingredients = @recipe.recipe_foods.includes(:food)
  end

  def index_public
    @recipes = if current_user
                 Recipe.where('user_id = ? OR public = ?', current_user.id, true)
               else
                 Recipe.where(public: true)
               end
    render 'index_public'
  end

  def new
    @user = current_user
    @recipe = Recipe.new
  end

  def create
    @recipe = current_user.recipes.build(recipe_params)

    if @recipe.save
      flash[:notice] = 'Recipe created'
      redirect_to my_recipes_path(current_user, @recipe)
    else
      flash[:alert] = 'Recipe not created'
      render :new
    end
  end

  def destroy
    @recipe = Recipe.find_by(id: params[:id])
    if @recipe.destroy
      flash[:notice] = 'Recipe Deleted'
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
      flash[:alert] = 'Recipe not deleted'

    end
  end

  def toggle_privacy
    @recipe = Recipe.find(params[:id])
    @recipe.update(public: !@recipe.public)
    redirect_to recipe_path(@recipe)
  end

  private

  def recipe_params
    params.require(:recipe).permit(:name, :description, :preparation_time, :cooking_time, :public)
  end
end
