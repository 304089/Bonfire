class PhotoPost < ApplicationRecord
  attachment :photo_image
  belongs_to :user, dependent: :destroy
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  belongs_to :genre
end
