class ConsultationAnswer < ApplicationRecord
  attachment :answer_image
  has_many :helpfulnesses
  belongs_to :user
  belongs_to :consultation

  def helped_by?(user)
    helpfulnesses.where(user_id: user.id).exists?
  end
end
