class PhotoPostCommentsController < ApplicationController

  def index
    @photo_post = PhotoPost.find(params[:photo_post_id])
    @photo_post_comments = PhotoPostComment.where(photo_post_id: photo_post.id)
    @photo_post_comment = PhotoPostComment.new
  end

  def create
    photo_post = PhotoPost.find(params[:photo_post_id])
    @photo_post_comment = PhotoPostComment.new(photo_post_comment_params)
    @photo_post_comment.user_id = current_user.id
    @photo_post_comment.photo_post_id = photo_post.id
    @photo_post_comment.save
    redirect_to request.referer
  end

  def destroy
  end

  private
    def photo_post_comment_params
      params.require(:photo_post_comment).permit(:comment)
    end
end
