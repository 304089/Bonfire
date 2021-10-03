class BookmarksController < ApplicationController

  def create
    @photo_post = PhotoPost.find(params[:photo_post_id])
    bookmark = current_user.bookmarks.new(photo_post_id: @photo_post.id)
    bookmark.save
  end

  def destroy
    @photo_post = PhotoPost.find(params[:photo_post_id])
    bookmark = current_user.bookmarks.find_by(photo_post_id: @photo_post.id)
    bookmark.destroy
  end

end
