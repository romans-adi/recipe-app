class FoodsController < ApplicationController
  before_action :authenticate_user!

  def index
    @current_user = current_user
    @foods = current_user.foods
  end

  def new
    @current_user = current_user
    @measurement_units = %w[grams kilograms liters milliliters pieces cups teaspoons tablespoons]
    @food = Food.new
  end

  def create
    @food = current_user.foods.new(food_params)

    if @food.save
      redirect_to foods_path, notice: 'Food successfully added'
    else
      flash[:alert] = 'Something went wrong, Try again!'
      render :new
    end
  end

  def destroy
    @food = Food.find(params[:id])
    @food.destroy
    redirect_to foods_path
  end

  private

  def food_params
    params.require(:food).permit(:name, :measurement_unit, :price, :quantity)
  end
end
