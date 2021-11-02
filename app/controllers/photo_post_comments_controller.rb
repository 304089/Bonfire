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
    @photo_post_comment.score = Language.get_data(photo_post_comment_params[:comment])
    @photo_post_comment.user_id = current_user.id
    @photo_post_comment.photo_post_id = @photo_post.id
    if @photo_post_comment.save
      if @photo_post_comment.score <= -0.5
        flash.now[:alert] = "このコメントに不適切な表現が含まれている可能性があります<br>場合によって管理者が削除することがあります".html_safe
      end

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
      params.require(:photo_post_comment).permit(:comment, :score)
    end
end
