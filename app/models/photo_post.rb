class PhotoPost < ApplicationRecord
  acts_as_taggable
  attachment :photo_image
  belongs_to :user
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  enum genre: {"キャンプ場": 0, "キャンプ道具": 1, "キャンプ料理": 2, "キャンプ初心者": 3}

  def self.search(keyword)
    if keyword == "" #未入力の場合は全権表示
      PhotoPost.all
    else
      PhotoPost.where(["introduction like?", "%#{keyword}%"])  #説明文の文字で部分検索
    end
  end

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user)
    bookmarks.where(user_id: user.id).exists?
  end
end
