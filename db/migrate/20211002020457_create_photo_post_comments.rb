class CreatePhotoPostComments < ActiveRecord::Migration[5.2]
  def change
    create_table :photo_post_comments do |t|
      t.references :photo_post, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :comment, null: false
      t.timestamps
    end
  end
end
