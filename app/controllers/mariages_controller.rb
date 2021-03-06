class MariagesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :search]
  before_action :set_mariage, only: [:show, :edit, :update, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @mariages = Mariage.order('created_at DESC').limit(3)
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
    @comments = @mariage.comments.includes(:user).order('created_at DESC')
  end

  def edit
  end

  def update
    if params[:mariage][:image_ids]
      params[:mariage][:image_ids].each do |image_id|
        image = @mariage.images.find(image_id)
        image.purge
      end
    end
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

  def search
    @mariages = SearchMariagesService.search(params[:keyword]).paginate(page: params[:page], per_page: 6)
  end

  private

  def mariage_params
    params.require(:mariage).permit(:title, :text, :category_id, :taste_id, images: [],
                                                                            images_attachments_attributes: [:id, :_destroy]).merge(user_id: current_user.id)
  end

  def set_mariage
    @mariage = Mariage.find(params[:id])
  end

  def move_to_index
    redirect_to action: :index unless @mariage.user_id == current_user.id
  end
end
