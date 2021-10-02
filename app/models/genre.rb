class Genre < ApplicationRecord
  belongs_to :photo_post
  belongs_to :consultation_answer
end
