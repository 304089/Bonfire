class CreateInfomations < ActiveRecord::Migration[5.2]
  def change
    create_table :infomations do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.integer :status,null: false,default: 0
      t.timestamps
    end
  end
end
