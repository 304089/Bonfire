class PhotoPostCommentsController < ApplicationController
  before_action :active_user, except:[:new, :index]


  def new
    @photo_post = PhotoPost.find(params[:photo_post_id])
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id)
    @photo_post_comment = PhotoPostComment.new
  end

  def index
    @photo_post = PhotoPost.find(params[:photo_post_id])
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id).order(id: "DESC").page(params[:page]).per(20)
    @photo_post_comment = PhotoPostComment.new
  end

  def create
    @photo_post = PhotoPost.find(params[:photo_post_id])
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id)
    @photo_post_comment = PhotoPostComment.new(photo_post_comment_params)
    @photo_post_comment.user_id = current_user.id
    @photo_post_comment.photo_post_id = @photo_post.id
    if @photo_post_comment.save
      render :comments
    else
      render :comments
    end
  end

  def destroy
    @photo_post = PhotoPost.find(params[:photo_post_id])
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id)
    @photo_post_comment = PhotoPostComment.find(params[:id])
    @photo_post_comment.destroy
    render :comments
  end

  private
    def photo_post_comment_params
      params.require(:photo_post_comment).permit(:comment)
    end
end
