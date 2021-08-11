class Comment < ApplicationRecord
  validates :text, presence: true

  belongs_to :mariage
  belongs_to :user 
end
