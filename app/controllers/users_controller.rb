class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    if params[:choose] == "mine" || params[:choose] == nil   #My Photo押すか、マイページに飛んできた時
      @title = "mine" #一覧のタイトル用
      if params[:sort] == "new" || params[:sort] == nil                                     #新しい順（デフォルトも）
        @photo_posts = PhotoPost.where(user_id: @user.id, preview: false).order(id: "DESC")
      elsif params[:sort] == "old"                                                          #古い順
        @photo_posts = PhotoPost.where(user_id: @user.id, preview: false)
      elsif params[:sort] == "favorite"                                                     #いいね順（0個は表示しない）
        @photo_posts = PhotoPost.joins(:favorites).group(:id).where(user_id: @user.id).order("count(favorites.id) DESC")
      end
    elsif params[:choose] == "bookmark" #ブックマークページ
      @title = "bookmark" #一覧のタイトル用
      @photo_posts = PhotoPost.joins(:bookmarks).where(bookmarks: { user_id: @user.id })
    elsif params[:choose] == "draft" # 下書きページ
      @title = "draft" #一覧のタイトル用
      @photo_posts = PhotoPost.where(user_id: @user.id, preview: true).order(id: "DESC")
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user)
  end

  def confirm
    @user = User.find(params[:id])
  end

  def leave
    @user = User.find(params[:id])
    @user.update(status: 1)
    reset_session
    flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
    redirect_to root_path
  end

  def revival
    @user = User.find(params[:id])
    @user.update(status: 0)
    redirect_to user_path(@user)
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:profile_image, :introduction, :choose, :sort)
  end


end
