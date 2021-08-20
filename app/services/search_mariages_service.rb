class SearchMariagesService
  def self.search(search)
    if search != ''
      Mariage.where('text LIKE(?)', "%#{search}%").order('created_at DESC')
    else
      Mariage.order('created_at DESC')
    end
  end
end
