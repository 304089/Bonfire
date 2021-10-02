class ConsultationAnswer < ApplicationRecord
  has_many :helpfulnesses
  belongs_to :user
  belongs_to :consultation
end
