class PhotoPost < ApplicationRecord
  acts_as_taggable
  belongs_to :user
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image

  enum genre: {"キャンプ場": 0, "キャンプ道具": 1, "キャンプ料理": 2, "キャンプ初心者": 3}

  def self.search(keyword)
    if keyword == "" #未入力の場合は全権表示
      PhotoPost.all
    else
      #説明文、場所名、タグ名で部分一致検索
      PhotoPost.joins(:tags).where(["introduction like? OR place like? OR tags.name like? ", "%#{keyword}%", "%#{keyword}%","%#{keyword}%"])
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
