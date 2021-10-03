class PhotoPostCommentsController < ApplicationController
  def create
    @photo_post_comment = PhotoPostComment.new(photo_post_comment_params)
    @photo_post_comment.user_id = current_user.id
    @photo_post_comment.save
    redirect_to photo_post_path(@photo_post_comment.photo_post.id)
  end

  def destroy
  end

  private
    def photo_post_comment_params
      params.require(:photo_post_comment).permit(:comment, :photo_post_id)
    end
end
