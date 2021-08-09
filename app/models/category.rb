class Category < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '和食' },
    { id: 3, name: '洋食' },
    { id: 4, name: '中華料理' },
    { id: 5, name: 'スイーツ' },
    { id: 6, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :mariages

  end