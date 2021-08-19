class SearchesController < ApplicationController

  def index
    @mariages = Mariage.order('created_at DESC').page(params[:page])
  end

  def search
    @mariages = @p.result.order('created_at DESC').page(params[:page])
  end

end
