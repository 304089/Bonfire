class CreatePlanItems < ActiveRecord::Migration[5.2]
  def change
    create_table :plan_items do |t|
      t.references :plan, foreign_key: true, null: false
      t.references :item, foreign_key: true, null: false
      t.timestamps
    end
  end
end
