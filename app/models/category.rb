class Category < ActiveHash::Base
  self.data = [
    { id: 0, name: '---' },
    { id: 1, name: '一般(常温)食品' },
    { id: 2, name: '冷凍食品' },
    { id: 3, name: '冷蔵食品' },
    { id: 4, name: '収穫物/家庭菜園' },
    { id: 5, name: '飲食店メニュー' },
    { id: 6, name: '手作り、ハンドメイド' },
    { id: 7, name: 'その他' }
  ]
  include ActiveHash::Associations
  has_many :items
end
