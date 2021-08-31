class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :set_user, only: [:show, :edit, :update]
  before_action :move_to_index, only: [:edit, :update]

  def show
    @mariages = @user.mariages.includes(:user)
  end

  def edit
  end

  def update
    if params[:user][:password].blank?
      params[:user].delete("password")
    end
    if current_user.update(user_params)
      redirect_to "/users/#{current_user.id}"
    else
      render :edit
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:nickname, :email)
  end

  def move_to_index
    redirect_to action: :index unless @user.user == current_user.id
  end
end
