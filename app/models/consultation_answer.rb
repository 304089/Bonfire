class ConsultationAnswer < ApplicationRecord
  validates :answer, {presence: true}

  attachment :answer_image
  has_many :helpfulnesses, dependent: :destroy
  belongs_to :consultation
  belongs_to :user

  def helped_by?(user)
    helpfulnesses.where(user_id: user.id).exists?
  end

  def set_date
    created_at.strftime("%Y年%m月%d日 %H:%M")
  end

end
