class CreateConsultationAnswers < ActiveRecord::Migration[5.2]
  def change
    create_table :consultation_answers do |t|
      t.references :consultation, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :answer, null: false
      t.string :answer_image_id
      t.timestamps
    end
  end
end
