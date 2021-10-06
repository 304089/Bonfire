class Consultation < ApplicationRecord
  attachment :consultation_image
  has_many :consultation_answers, dependent: :destroy
  belongs_to :user
  enum status: {"未解決": 0, "解決": 1}
  enum genre: {"キャンプ場": 0, "キャンプ道具": 1, "キャンプ料理": 2, "その他": 3}
end
