class MariagesController < ApplicationController
  def index
  end

  def new
    @mariage = Mariage.new
  end

  def create
  end


  private

  def mariage_params
    params.require(:mariage).permit(:image).merge(user_id: current_user.id)
  end
end
