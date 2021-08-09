class Taste < ActiveHash::Base
  self.data = [
    { id: 1, name: '--' },
    { id: 2, name: '香りを楽しめるタイプ' },
    { id: 3, name: '軽くてスッキリとした飲み口' },
    { id: 4, name: 'コクのあるふくよかな味わい' },
    { id: 5, name: '熟成された深い味わい' },
    { id: 6, name: 'その他' }
  ]

  include ActiveHash::Associations
  has_many :mariages
  end