class Helpfulness < ApplicationRecord
  belongs_to :user
  belongs_to :consultation_answer
end
