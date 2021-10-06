class Consultation < ApplicationRecord
  attachment :consultation_image
  has_many :consultation_answers, dependent: :destroy
  belongs_to :user
  belongs_to :consultation_genre
  enum status: {"未解決": 0, "解決": 1}, _prefix: true
end
