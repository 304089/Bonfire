class Consultation < ApplicationRecord
  attachment :consultation_image
  has_many :consultation_answers, dependent: :destroy
  belongs_to :user
  belongs_to :consultation_genre
end
