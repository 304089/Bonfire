class Plan < ApplicationRecord

  with_options presence: true do
    validates :title
    validates :day
    validates :place
    validates :member
  end

  belongs_to :user
  has_many :plan_items, dependent: :destroy
  has_many :items, through: :plan_items

end
