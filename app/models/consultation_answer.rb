class ConsultationAnswer < ApplicationRecord
  attachment :answer_image
  has_many :helpfulnesses
  belongs_to :user
  belongs_to :consultation
end
