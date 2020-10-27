class SessionsController < ApplicationController
  skip_before_action :login_required

  def new
  end

  def create
    user = User.find_by(email: session_params[:email])

    if user&.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: 'ログインしました'
    else
      flash[:error] = 'メールアドレス又はパスワードが誤っています'
      render :new
    end
  end

  def destroy
    # user_idのみの削除
    # session.delete(:user_id)
    # セッション内のデータを全て削除
    reset_session
    redirect_to root_path, notice: 'ログアウトしました'
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
