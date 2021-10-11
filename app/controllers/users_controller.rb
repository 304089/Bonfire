class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
    @photo_posts = PhotoPost.where(user_id: @user.id, preview: false).order(id: "DESC")
  end

  def index
    @users = User.all
  end

  def my_post
    @user = User.find(params[:id])
    @photo_posts = PhotoPost.where(user_id: @user.id, preview: false).order(id: "DESC")
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
    params.require(:user).permit(:name,:email,:profile_image, :introduction)
  end
end
