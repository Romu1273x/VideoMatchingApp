class UsersController < ApplicationController
  def new
    # 新規ユーザー登録ページの初期値
    @user = User.new
  end

  def create
    # 新規ユーザー登録ページで入力されたデータを取得
    @user = User.new(
      user_id: params[:user_id],
      hdl_name: params[:hdl_name],
      password: params[:password],
      content: ""
    )
    if @user.save
      # ユーザ登録できた場合、ユーザー詳細ページを表示する
      redirect_to("/users/#{@user.id}")
    else
      # ユーザ登録できなかった場合、入力情報を再表示する
      render("users/new")
    end
  end

  def login_form
  end

  def login
    # ログインページで入力されたデータを元にユーザーを特定
    @user = User.find_by(user_id: params[:user_id])
    if @user && (@user.password == (params[:password]))
      # ログインした場合、投稿ページを表示する
      redirect_to("/posts/index")
    else
      # ログインできなかった場合、入力情報を再表示する
      @user_id = params[:user_id]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    # 編集されたユーザー情報を取得
    @user = User.find_by(id:params[:id])
    @user.hdl_name = params[:hdl_name]
    @user.content = params[:content]
    if @user.save
      # ユーザー情報更新できた場合、マイページを表示する
      redirect_to("/users/#{@user.id}")
    else
      # ユーザー情報更新できた場合、入力情報を再表示する
      render("users/edit")
    end
  end

  def show
    @user = User.find_by(id:params[:id])
  end

  def index
    # 全てのユーザー情報を取得
    @users = User.all
  end
end
