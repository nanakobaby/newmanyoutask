class ApplicationController < ActionController::Base
  before_action :set_current_user
  #セキュリティトークンが自動的にすべてのフォームに含まれる
  protect_from_forgery with: :exception
  include SessionsHelper
  # ログイン中のユーザの取得の共通化
  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    # 現在ログイン中のユーザが存在しない場合、ログインページにリダイレクトさせる。
    if @current_user == nil
      flash[:notice] = t('notice.login_needed')
      redirect_to new_session_path
    end
  end
  # ログインユーザを禁止する
  def forbid_login_user
    if @current_user
      flash[:notice] = t('notice.already_logged_in')
      redirect_to tasks_path
    end
  end
end
