class Admin::UsersController < ApplicationController
  before_action :admin_user, only: [:new, :index, :show, :edit, :update, :destroy]
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    @users = User.all.order("created_at ASC")
    @users = @users.page(params[:page]).per(10)
  end

  def show
    @tasks = @user.tasks
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to admin_users_path, notice: t('notice.user_create')
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to admin_users_path, notice: t('notice.user_update')
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      redirect_to admin_users_path, notice: t('notice.user_deleted')
    else
      redirect_to admin_users_path, notice: t('notice.user_not_deleted')
    end
  end

  private
  def admin_user
    # admin以外のユーザはrootにリダイレクトさせる
    if not current_user.admin
      flash[:notice] = t('notice.not_administrator')
      redirect_to(root_path)
    end
  end

  def user_params
    params.require(:user).permit(:name, :email, :admin, :password, :password_confirmation)
  end

  def set_admin
    @user = User.find(params[:id])
  end
end
