class UsersController < ApplicationController
  before_action :authenticate_user, { only: [:index, :show, :edit, :update] }
  before_action :forbid_login_user, {only: :new}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end
  #認証されたユーザかを確かめる
  def authenticate_user
    # params[:id]で取得できるのは文字列、@current_user.idは数値。to_iメソッドを用いて文字列を数値に変換。
    if @current_user.id != params[:id].to_i
      flash[:notice] = t('notice.not_authorized')
      redirect_to tasks_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation)
  end
end
