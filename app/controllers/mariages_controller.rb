class MariagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # @mariage = Mariage.order(created_at: :desc).limit(5)
    query = 'SELECT * FROM mariages order by created_at DESC'
    @mariages = Mariage.find_by_sql(query)
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

  def show
    @mariage = Mariage.find(params[:id])
  end

  def edit
    @mariage = Mariage.find(params[:id])
    unless @mariage.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    @mariage = Mariage.find(params[:id])
    if @mariage.update(mariage_params)
      redirect_to mariage_path(@mariage)
    else
      render :edit
    end
  end

  def destroy
    mariage = Mariage.find(params[:id])
    mariage.destroy
    redirect_to root_path
  end


  private

  def mariage_params
    params.require(:mariage).permit(:title, :text, :category_id, :taste_id, :image).merge(user_id: current_user.id)
  end
end
