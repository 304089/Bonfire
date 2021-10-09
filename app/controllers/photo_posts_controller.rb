class PhotoPostsController < ApplicationController

  def new
    @photo_post = PhotoPost.new
  end

  def create
    @photo_post = PhotoPost.new(photo_post_params)
    @photo_post.user_id = current_user.id
    if @photo_post.save
      redirect_to user_path(@photo_post.user)
    else
      render "new"
    end
  end

  def show
    @photo_post = PhotoPost.find(params[:id])
    @photo_post_comment = PhotoPostComment.new
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id)
  end

  def index
    @photo_posts = PhotoPost.all.order(id: "DESC")
  end

  def destroy
  end

  def search
    @photo_posts = PhotoPost.search(params[:keyword]).order(id: "DESC")
    @keyword = params[:keyword]
  end

  private
  def photo_post_params
    params.require(:photo_post).permit(:introduction, :photo_image, :genre, :tag_list, post_images_images: [])
  end

end
