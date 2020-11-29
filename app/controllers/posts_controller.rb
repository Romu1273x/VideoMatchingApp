class PostsController < ApplicationController
  def new
    # 新規投稿ページの初期値
    @post = Post.new
  end

  def create
    # 新規投稿ページで入力された情報を取得
    @post = Post.new(
      user_id: @current_user.user_id,
      title: params[:title],
      select: params[:select],
      price: params[:price],
      period: params[:period],
      content: params[:content]
    )
    if @post.save
      # 投稿できた場合、投稿一覧ページを表示する
      redirect_to("/posts/index")
    else
      # 投稿できなかった場合、入力情報を再表示する
      render("posts/new")
    end
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def update
    # 投稿編集ページで入力された情報を取得
    @post = Post.find_by(id: params[:id])
    @post.title = params[:title]
    @post.select = params[:select]
    @post.price = params[:price]
    @post.period = params[:period]
    @post.content = params[:content]
    if @post.save
      # 更新できた場合、投稿一覧ページを表示する
      redirect_to("/posts/index")
    else
      # 更新できなかった場合、入力情報を再表示する
      render("posts/edit")
    end
  end

  def destroy
    # 投稿ページ情報を取得
    @post = Post.find_by(id: params[:id])
    if @post.destroy
      # 削除できた場合、投稿一覧ページを表示する
      redirect_to("/posts/index")
    end
  end

  def index
    # 投稿一覧を取得
    @posts = Post.all
  end

  def show
    # 投稿ページ情報を取得
    @post = Post.find_by(id:params[:id])
  end
end
