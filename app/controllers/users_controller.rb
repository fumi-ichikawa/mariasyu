class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @mariages = @user.mariages.includes(:user)
  end
end
