class CreatePostImages < ActiveRecord::Migration[5.2]
  def change
    create_table :post_images do |t|
      t.references :photo_post, foreign_key: true, null: false
      t.string :image_id, null: false
      t.timestamps
    end
  end
end
