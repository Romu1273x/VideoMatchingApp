class LikesController < ApplicationController

  def create
    # 投稿ページからお気に入りを新規作成
    @like = Like.create(user_id: @current_user.id, post_id: params[:post_id])
    redirect_to(post_path(@like.post_id))
  end

  def destroy
    # 投稿ページからお気に入りを削除
    @like = Like.find_by(user_id: @current_user.id, post_id: params[:post_id])
    @like.destroy
    redirect_to(post_path(@like.post_id))
  end

end