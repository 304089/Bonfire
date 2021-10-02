class Bookmark < ApplicationRecord
  belongs_to :user
  belongs_to :photo_post
end
