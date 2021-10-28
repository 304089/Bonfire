class Item < ApplicationRecord

  with_options presence: true do
    validates :genre
    validates :name
  end

  belongs_to :user
  has_many :plan_items
  has_many :plans, through: :plan_items


  attachment :item_image

  enum genre: {"テント・タープ": 0,
    "テーブル・チェア": 1,
    "調理道具": 2,
    "照明器具": 3,
    "焚き火道具": 4,
    "寝具": 5,
    "収納": 6,
    "燃料": 7,
    "その他": 8
  }


end
