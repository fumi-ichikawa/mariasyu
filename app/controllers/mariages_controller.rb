class MariagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_mariage, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    # @mariage = Mariage.order(created_at: :desc).limit(5)
    query = 'SELECT * FROM mariages order by created_at DESC LIMIT 3'
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
    @comment = Comment.new
    @comments = @mariage.comments.includes(:user)
  end

  def edit
  end

  def update
    if @mariage.update(mariage_params)
      redirect_to mariage_path(@mariage)
    else
      render :edit
    end
  end

  def destroy
    @mariage.destroy
    redirect_to root_path
  end

  private

  def mariage_params
    params.require(:mariage).permit(:title, :text, :category_id, :taste_id, :image).merge(user_id: current_user.id)
  end

  def set_mariage
    @mariage = Mariage.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @mariage.user_id == current_user.id
  end
end
