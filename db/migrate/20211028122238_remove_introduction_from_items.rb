class RemoveIntroductionFromItems < ActiveRecord::Migration[5.2]
  def change
    remove_column :items, :introduction, :text
  end
end
