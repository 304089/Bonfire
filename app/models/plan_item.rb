class PlanItem < ApplicationRecord
  belongs_to :item
  belongs_to :plan
end
