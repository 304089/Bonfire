class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true, null: false
      t.string :name, nill: false
      t.string :manufacturer
      t.integer :genre, null: false
      t.text :introduction
      t.string :item_image_id
      t.timestamps
    end
  end
end