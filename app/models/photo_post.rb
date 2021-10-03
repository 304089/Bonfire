class PhotoPost < ApplicationRecord
  attachment :photo_image
  belongs_to :user
  belongs_to :photo_post_genre
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
