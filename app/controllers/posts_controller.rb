class PostsController < ApplicationController
  # 非ログインユーザーに制限をかける
  before_action :authenticate_user, {except: [:index]}
  # 投稿ページに制限をかける
  before_action :ensure_correct_user, {only: [:edit, :update, :destroy]}

  def new
    # 新規投稿ページの初期値
    @post = Post.new
  end

  def create
    # 新規投稿ページで入力された情報を取得
    @post = Post.new(post_params.merge(user_id: @current_user.id))
    if @post.save
      # 投稿できた場合、投稿一覧ページを表示する
      flash[:notice] = "投稿しました"
      redirect_to(posts_path)
    else
      # 投稿できなかった場合、入力情報を再表示する
      @error_message = "入力情報が間違っています"
      render(action: "new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    # 投稿編集ページで入力された情報を取得
    @post = Post.find_by(id: params[:id])
    if @post.update(post_params)
      # 更新できた場合、投稿一覧ページを表示する
      flash[:notice] = "投稿を編集しました"
      redirect_to(posts_path)
    else
      # 更新できなかった場合、入力情報を再表示する
      @error_message = "入力情報が間違っています"
      render(action: "edit")
    end
  end

  def destroy
    # 投稿ページ情報を取得
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      # 削除できた場合、投稿一覧ページを表示する
      flash[:notice] = "投稿を削除しました"
      redirect_to(posts_path)
    end
  end

  def index
    # 投稿一覧を取得
    @posts = Post.all
  end

  def show
    # 投稿ページ情報を取得
    @post = Post.find_by(id: params[:id])
    # お気に入り
    @like = Like.find_by(user_id: @current_user.id, post_id: @post.id)
  end

  def ensure_correct_user
    # 作成者以外が変更できないように制限をかける
    @post = Post.find_by(id: params[:id])
    if @post.user_id != @current_user.id
      flash[:notice] = "権限がありません"
      redirect_to(posts_path)
    end
  end

  private
  def post_params
    params.require(:post).permit(:title, :select, :period, :price, :content)
  end

end
