class Admin::UsersController < ApplicationController
  before_action :admin_user

  def top
    @user_data= User.group("date(created_at)").count  #管理者TOPページにユーザーの登録状況をグラフ化するためカウント
  end

  def index
    if params[:sort] == "old" || params[:sort] == nil                                     #登録順
      @users = User.where(status: 0).page(params[:page]).per(30)
    elsif params[:sort] == "new"                                                          #新しい順
      @users = User.where(status: 0).order(id: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "near"                                                         #最終ログイン時間が近い順
      @users = User.where(status: 0).order(current_sign_in_at: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "far"                                                          #最終ログイン時間が遠い順
      @users = User.where(status: 0).order(current_sign_in_at: "ASC").page(params[:page]).per(30)
    elsif params[:sort] == "leave"                                                        #退会者
      @users = User.where(status: 1).page(params[:page]).per(30)
      @status = "leave"
    elsif params[:sort] == "punish"                                                       #垢BANリスト
      @users = User.where(status: 2).page(params[:page]).per(30)
      @status = "punish"
    end
  end

  def change  #ユーザー一覧ページにて、会員と垢BANのステータス変更時
    @user = User.find(params[:id])
    if @user.status == "会員"
      @user.update(status: 2)
      redirect_to request.referer
    elsif @user.status == "垢BAN"
      @user.update(status: 0)
      redirect_to request.referer
    end
  end

  def search
    @users = User.search(params[:keyword]).page(params[:page]).per(30)
    @keyword = params[:keyword]
  end

end
