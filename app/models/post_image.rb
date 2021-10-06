class PostImage < ApplicationRecord
  belongs_to :photo_post
  attachment :image
end
