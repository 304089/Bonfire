class CreateInfomations < ActiveRecord::Migration[5.2]
  def change
    create_table :infomations do |t|
      t.string :email, null: false
      t.string :genre, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end