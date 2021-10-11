class PhotoPostsController < ApplicationController

  def new
    @photo_post = PhotoPost.new
    @user = current_user
  end

  def preview
    @photo_post = PhotoPost.find(params[:id])
    @preview = true
  end

  def create
    @photo_post = PhotoPost.new(photo_post_params)
    @photo_post.user_id = current_user.id
    if @photo_post.save
      redirect_to preview_photo_post_path(@photo_post)
    else
      render "new"
    end
  end

  def edit

  end

  def update
    @photo_post = PhotoPost.find(params[:id])
    if @photo_post.preview == true                #*********** 下書き状態なら投稿
      if @photo_post.update(preview: false)  #**********下書きから投稿へ変更した時間を作成日にする
        redirect_to user_path(@photo_post.user)
      end
    else
      @photo_post.record_timestamps = false       #*************更新日＝投稿日にするため、普通の内容編集の際は更新日を変えさせない
      if @photo_post.update
        redirect_to photo_post_path(@photo_post)
      end
    end
    @photo_post.record_timestamps = true
  end

  def show
    @photo_post = PhotoPost.find(params[:id])
    @photo_post_comment = PhotoPostComment.new
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id)
  end

  def index
    @photo_posts = PhotoPost.where(preview: false).order(id: "DESC")
  end

  def destroy
  end

  def search
    @photo_posts = PhotoPost.search(params[:keyword]).order(id: "DESC")
    @keyword = params[:keyword]
  end

  private
  def photo_post_params
    params.require(:photo_post).permit(:introduction, :photo_image,:genre, :tag_list,:place, :preview,
      post_images_images: [])
  end

end
