class CreatePlans < ActiveRecord::Migration[5.2]
  def change
    create_table :plans do |t|
      t.references :user, foreign_key: true, null: false
      t.string :title, null: false
      t.date :day, null: false
      t.string :place, null: false
      t.time :check_in_time
      t.time :check_out_time
      t.text :memo
      t.timestamps
    end
  end
end
