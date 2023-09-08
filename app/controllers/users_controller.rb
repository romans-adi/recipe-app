class UsersController < ApplicationController
  before_action :authenticate_user!

  private

  def set_default_role
    self.role ||= 'user'
  end
end
