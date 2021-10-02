class PhotoPostComment < ApplicationRecord
  belongs_to :user
  belongs_to :photo_post
end
