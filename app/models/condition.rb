class Condition < ActiveHash::Base
  self.data = [
    { id: 1, name: '---' },
    { id: 2, name: '新品同様,未開封,損傷/劣化なし' },
    { id: 3, name: '未開封,損傷/劣化なし' },
    { id: 4, name: '未開封,損傷/劣化あり' },
    { id: 5, name: '開封済み,収穫物,その他' }
  ]
  include ActiveHash::Associations
  has_many :items
end
