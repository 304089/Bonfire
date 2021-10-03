class CreateConsultations < ActiveRecord::Migration[5.2]
  def change
    create_table :consultations do |t|
      t.references :user, foreign_key: true, null: false
      t.references :consultation_genre, foreign_key: true, null: false
      t.string :title, null: false
      t.text :content, null: false
      t.string :consultation_image_id
      #trueで匿名
      t.boolean :anonymity, null: false, default: false
      t.timestamps
    end
  end
end
