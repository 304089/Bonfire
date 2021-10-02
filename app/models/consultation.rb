class Consultation < ApplicationRecord
  has_many :consultations_answers
  belongs_to :user
  belongs_to :genre
end
