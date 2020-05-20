class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  rescue_from ActiveRecord::RecordNotFound, with: :render_404
  rescue_from ActionController::RoutingError, with: :render_404
  rescue_from Exception, with: :render_500

  def render_404(exception = nil)
    if exception
      logger.info "Rendering 404 with exception: #{exception.message}"
    end
    render template: "errors/error_404", status: 404, layout: 'application'
  end

  def render_500(exception = nil)
    if exception
      logger.info "Rendering 500 with exception: #{exception.message}"
    end
    render template: "errors/error_500", status: 500, layout: 'application'
  end

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
