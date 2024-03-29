class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  #退会、垢BANはログイン後退会・垢BAN事実確認ページに移行
  def after_sign_in_path_for(resource)
    if current_user.status == "管理者"
      top_admin_users_path
    elsif current_user.status == "会員"
      user_path(current_user)
    elsif current_user.status == "退会"
      confirm_user_path(current_user)
    elsif current_user.status == "垢BAN"
      confirm_user_path(current_user)
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  def active_user #正規ユーザーかどうか
    if user_signed_in?
      unless current_user.status == "管理者" || current_user.status == "会員"
        redirect_to confirm_user_path(current_user) #違ったら退会、垢BANは退会・垢BAN事実確認ページに移行
      end
    else
      redirect_to root_path
    end
  end

  def admin_user #管理者かどうか
    unless current_user.status == "管理者"
      redirect_to root_path
    end
  end

end
