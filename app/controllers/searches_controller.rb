class SearchesController < ApplicationController

  def index
    @mariages = Mariage.order('created_at DESC')
  end

  def search
    @results = @p.result
  end

end
