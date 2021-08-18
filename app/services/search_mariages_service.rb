class SearchMariagesService
  def self.search(search)
    if search != ""
      Mariage.where('text LIKE(?)', "%#{search}%")
    else
      Mariage.all
    end
  end
end