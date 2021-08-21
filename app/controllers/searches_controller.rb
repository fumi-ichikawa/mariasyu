class SearchesController < ApplicationController
  def index
    @mariages = Mariage.order('created_at DESC').paginate(page: params[:page], per_page: 6)
  end

  def search
    @mariages = @p.result.order('created_at DESC').paginate(page: params[:page], per_page: 6)
  end
end
