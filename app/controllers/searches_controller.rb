class SearchesController < ApplicationController
  before_action :search_mariage, only: [:index, :search]

  def index
    @mariages = Mariage.order('created_at DESC')
  end

  def search
    @results = @p.result
    # @mariages = SearchMariagesService.search(params[:keyword])
  end

  private

  def search_mariage
    @p = Mariage.ransack(params[:q])  # 検索オブジェクトを生成
  end
end
