class FavoritesController < ApplicationController

  def create
    photo_post = PhotoPost.find(params[:photo_post_id])
    favorite = current_user.favorites.new(photo_post_id: photo_post.id)
    favorite.save
    redirect_to photo_post_path(photo_post)
  end

  def destroy
    photo_post = PhotoPost.find(params[:photo_post_id])
    favorite = current_user.favorites.find_by(photo_post_id: photo_post.id)
    favorite.destroy
    redirect_to photo_post_path(photo_post)
  end

end
