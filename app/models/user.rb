class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable #最終ログイン時間等表示のため追加

  attachment :profile_image

  has_many :photo_posts, dependent: :destroy
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :consultations, dependent: :destroy
  has_many :consultation_answers, dependent: :destroy
  has_many :helpfulnesses, dependent: :destroy
  has_many :relations,class_name: "Relation",foreign_key: "follower_id",dependent: :destroy
  has_many :followings,through: :relations,source: :followed
  has_many :reverse_of_relations,class_name: "Relation",foreign_key: "followed_id",dependent: :destroy
  has_many :followers,through: :reverse_of_relations,source: :follower

  enum status: {"会員": 0, "退会": 1, "垢BAN": 2, "管理者": 99}

  def self.search(keyword)
    if keyword == "" #未入力の場合は全件表示
      User.where(admin: false)
    else              #名前の部分一致
      User.where(['name like?', "%#{keyword}%"]).where(admin: false)
    end
  end

end
