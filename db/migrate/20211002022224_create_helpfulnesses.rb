class CreateHelpfulnesses < ActiveRecord::Migration[5.2]
  def change
    create_table :helpfulnesses do |t|
      t.references :user, foreign_key: true, null: false
      t.references :consultation_answer, foreign_key: true, null: false
      t.timestamps
    end
  end
end
