class SessionsController < ApplicationController

  def new
  end
  def create
    #find_byメソッドでデータベースから該当するレコードを検索。
    user = User.find_by(email: params[:session][:email].downcase)
    #has_secure_passwordが提供するauthenticateメソッドを使用し、パスワード一致を確認。
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash.now[:danger] = t('view.login_failed')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    flash[:notice] = t('view.logged_out')
    redirect_to new_session_path
  end
end
