class Mariage < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :taste

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_one_attached :image

  with_options presence: true do
    validates :image
    validates :title
    validates :text
  end

  with_options numericality: { other_than: 1, message: "can't be blank" } do
    validates :category_id
    validates :taste_id
  end
end
