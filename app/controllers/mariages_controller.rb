class MariagesController < ApplicationController
  def index
  end

  def new
    @mariage = Mariage.new
  end

  def create
    @mariage = Mariage.create(mariage_params)
    if @mariage.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def mariage_params
    params.require(:mariage).permit(:title, :text, :category_id, :taste_id, :image).merge(user_id: current_user.id)
  end
end
