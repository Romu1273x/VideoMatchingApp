class UsersController < ApplicationController
  # 非ログインユーザーに制限をかける
  before_action :authenticate_user, {only: [:index, :show, :edit, :update]}
  # ログイン済ユーザーに制限をかける
  before_action :forbid_login_user, {only: [:new, :create, :login_form, :login]}
  # ユーザー専用ページにアクセス制限
  before_action :ensure_correct_user, {only: [:edit, :update]}

  def new
    # 新規ユーザー登録ページの初期値
    @user = User.new
  end

  def create
    # 新規ユーザー登録ページで入力されたデータを取得
    @user = User.new(params.require(:user)
            .permit(:user_id, :hdl_name, :password)
            .merge(content: ""))
    if @user.save
      # ユーザ登録できた場合、カレントユーザーIDを保持し、ユーザー詳細ページを表示する
      session[:user_id] = @user.id
      flash[:notice] = "ユーザー登録が完了しました"
      redirect_to("/users/#{@user.id}")
    else
      # ユーザ登録できなかった場合、入力情報を再表示する
      @error_message = "入力情報が間違っています"
      render("users/new")
    end
  end

  def login_form
  end

  def login
    # ログインページで入力されたデータを元にユーザーを特定
    @user = User.find_by(user_id: params[:user_id])
    if @user && @user.authenticate(params[:password])
      # ログインした場合、カレントユーザーIDを保持し、投稿ページを表示する
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました"
      redirect_to(posts_path)
    else
      # ログインできなかった場合、入力情報を再表示する
      @error_message = "ユーザーIDまたはパスワードが間違っています"
      @user_id = params[:user_id]
      @password = params[:password]
      render("users/login_form")
    end
  end

  def logout
    # カレントユーザーIDを空にし、ログインページを表示する
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました"
    redirect_to("/login")
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def update
    # 編集されたユーザー情報を取得
    @user = User.find_by(id: params[:id])
    if @user.update(params.require(:user).permit(:hdl_name, :content))
      # ユーザー情報更新できた場合、マイページを表示する
      flash[:notice] = "ユーザー情報を編集しました"
      redirect_to("/users/#{@user.id}")
    else
      # ユーザー情報更新できた場合、入力情報を再表示する
      @error_message = "入力情報が間違っています"
      render("users/edit")
    end
  end

  def show
    @user = User.find_by(id: params[:id])
    # DM機能。カレントユーザーとユーザーのEntryテーブルを取得
    @current_user_entry = Entry.where(user_id: @current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    if @user.id != @current_user.id
      # カレントユーザーとユーザーが同一でなければ、room_idを比較
      @current_user_entry.each do |cue|
        @user_entry.each do |ue|
          if cue.room_id == ue.room_id
            # 同一のルームだった場合、roomのidとルームが存在した事を示すフラグを保持
            @room_id = cue.room_id
            @room_flag = true
          end
        end
      end
      if @room_flag != true
        # もしルームが存在しなかった場合、EntryテーブルとRoomテーブルを作成
        @room = Room.new
        @entry = Entry.new
      end
    end

  end

  def index
    # 全てのユーザー情報を取得
    @users = User.all
  end

  def likes
    # ユーザーがお気に入りした投稿を検索
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def ensure_correct_user
    # 対象のユーザーだけが専用ページにアクセスできるように制限
    if @current_user.id != params[:id].to_i
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end

end
