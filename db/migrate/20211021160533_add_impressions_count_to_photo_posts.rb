class AddImpressionsCountToPhotoPosts < ActiveRecord::Migration[5.2]
  def change
    add_column :photo_posts, :impressions_count, :integer, default: 0
  end
end
