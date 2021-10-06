class CreatePhotoPosts < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_posts do |t|
      t.references :user, foreign_key: true, null: false
      t.integer :genre, null: false
      t.text :introduction, null: false
      t.timestamps
    end
  end
end
