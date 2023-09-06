class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.includes(:recipes).all
    @user = current_user
    @recipes = Recipe.accessible_by(current_ability)
    
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def set_default_role
    self.role ||= 'user'
  end
end
