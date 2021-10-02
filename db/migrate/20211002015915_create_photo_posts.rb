class CreatePhotoPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_posts do |t|
      t.references :user, foreign_key: true, null: false
      t.references :genre, foreign_key: true, null: false
      t.text :introduction, null: false
      t.string :photo_image_id, null: false
      t.timestamps
    end
  end
end
