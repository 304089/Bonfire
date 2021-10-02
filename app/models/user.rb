class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :photo_posts, dependent: :destroy
  has_many :photo_post_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :consultations, dependent: :destroy
  has_many :consultation_answers, dependent: :destroy
  has_many :helpfulnesses, dependent: :destroy

  def admin?
    self.admin == true
  end

end
