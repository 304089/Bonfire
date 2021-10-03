class PhotoPostComment < ApplicationRecord
  validates :comment, {presence: true}
  belongs_to :user
  belongs_to :photo_post
end
