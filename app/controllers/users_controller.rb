class UsersController < ApplicationController
  #ログイン中のユーザのみ表示
  before_action :authenticate_user, {only: [:logout, :show, :edit, :update]}
  #ログイン中のユーザは表示できない
  before_action :forbit_login_user, {only: [:new, :create]}
  #当事者のみ閲覧可能設定 #updateとdestroyはadmin編集のため記載していないので注意！
  before_action :ensure_correct_user, {only: [:edit]}

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_top_path, notice:'新規登録しました'
    else
      render :new
    end
  end

  def login_form
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to home_top_path, notice:'ログインしました'
    else
      #login_formで@userが定義不可な為、エラーメッセージを自作する必要がある。
      @error_message = "メールアドレスまたはパスワードが間違っています"
      render("users/login_form")
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to login_path, notice:'ログアウトしました'
  end

  def show
    @user = User.find_by(id: params[:id])
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update_attributes(user_params)
    if @user.save
      redirect_to home_top_path, notice:'プロフィールを編集しました'
    else
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :password)
  end
end
