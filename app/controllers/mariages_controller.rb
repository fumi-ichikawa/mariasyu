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
  end

  def edit
  end

  def update
  end

  def destroy
  end
  

  private

  def mariage_params
    params.require(:mariage).permit(:title, :text, :category_id, :taste_id, :image).merge(user_id: current_user.id)
  end
end
