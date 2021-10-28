class AddMemberToPlans < ActiveRecord::Migration[5.2]
  def change
    add_column :plans, :member, :integer
  end
end
