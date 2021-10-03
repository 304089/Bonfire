class Consultation < ApplicationRecord
  attachment :consultation_image
  has_many :consultations_answers
  belongs_to :user
  belongs_to :consultation_genre
end
