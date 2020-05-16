class Admin::UsersController < ApplicationController
  before_action :admin_user

  def index
    @users = User.all.order("created_at DESC")
  end

  private
  def admin_user
    # admin以外のユーザはrootにリダイレクトさせる
    if not current_user.admin
      flash[:notice] = t('notice.not_administrator')
      redirect_to(root_path)
    end
  end
end
