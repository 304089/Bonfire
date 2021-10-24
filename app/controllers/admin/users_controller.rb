class Admin::UsersController < ApplicationController
  before_action :admin_user

  def top
    @user_data= User.group("date(created_at)").count
  end

  def index

    if params[:sort] == "old" || params[:sort] == nil                                    #登録順
      @users = User.where(admin: false).page(params[:page]).per(30)
    elsif params[:sort] == "new"                                                          #新しい順
      @users = User.where(admin: false).order(id: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "near"                                                     #最終ログイン時間が近い順
      @users = User.where(admin: false).order(current_sign_in_at: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "far"                                                     #最終ログイン時間が遠い順
      @users = User.where(admin: false).order(current_sign_in_at: "ASC").page(params[:page]).per(30)
    elsif params[:sort] == "punish"                                                     #垢BANリスト
      @users = User.where(admin: false, active: false).page(params[:page]).per(30)
    end
  end

  def punish
    @user = User.find(params[:id])
    @user.update(active: false)
    redirect_to request.referer
  end

  def search
    @users = User.search(params[:keyword]).page(params[:page]).per(30)
    @keyword = params[:keyword]
  end

  private

  def admin_user
    if user_signed_in?
      if current_user.admin == false
        redirect_to root_path
      end
    else
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:name,:email,:profile_image, :introduction, :active, :sort)
  end


end
