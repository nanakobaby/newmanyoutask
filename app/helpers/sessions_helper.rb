module SessionsHelper
  def current_user
    # @current_user || @current_user = User.find_by(id: session[:user_id])と同じ。@current_userが偽の場合は、右辺を代入する。
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    #presentメソッドを使用し、レシーバーの値が存在すればtrue、しなければfalseを返す。
    current_user.present?
  end
end
