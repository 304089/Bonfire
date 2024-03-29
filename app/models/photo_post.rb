class PhotoPost < ApplicationRecord

  with_options presence: true do
    validates :genre
    validates :introduction, length: { in: 1..1000 }
    validates :post_images_images
  end

  acts_as_taggable  #タグ
  belongs_to :user
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :post_images, dependent: :destroy
  accepts_attachments_for :post_images, attachment: :image, append: true

  is_impressionable counter_cache: true #pv計測用

  enum genre: {"キャンプ場": 0, "キャンプ道具": 1, "キャンプ料理": 2, "キャンプ初心者": 3}

  def self.search(keyword)
    if keyword == "" #未入力の場合は全権表示
      PhotoPost.all
    else
      #説明文、場所名、タグ名で部分一致検索
      PhotoPost.joins(:tags).where(['introduction like? OR place like? OR tags.name like?', "%#{keyword}%","%#{keyword}%","%#{keyword}%"])
    end
  end

  def favorited_by?(user)   #いいね済みかどうか
    favorites.where(user_id: user.id).exists?
  end

  def bookmarked_by?(user) #ブックマーク済みかどうか
    bookmarks.where(user_id: user.id).exists?
  end
end
