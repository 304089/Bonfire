class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if params[:choose] == "mine" || params[:choose] == nil   #My Photo押すか、マイページに飛んできた時
      if params[:sort] == "new" || params[:sort] == nil
        @photo_posts = PhotoPost.where(user_id: @user.id, preview: false).order(id: "DESC")
      elsif params[:sort] == "old"
        @photo_posts = PhotoPost.where(user_id: @user.id, preview: false)
      end
    elsif params[:choose] == "bookmark" #ブックマークページ
      @photo_posts = PhotoPost.joins(:bookmarks).where(bookmarks: { user_id: @user.id })
    elsif params[:choose] == "draft" # 下書きページ
      @photo_posts = PhotoPost.where(user_id: @user.id, preview: true).order(id: "DESC")
    end
  end

  def index
  end

  def my_post
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def unsubscribe
    @user = User.find(params[:id])
  end

  private
  def user_params
    params.require(:user).permit(:name,:email,:profile_image, :introduction, :choose, :sort)
  end
end
