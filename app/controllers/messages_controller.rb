class MessagesController < ApplicationController

  def create
    if Entry.where(user_id: @current_user.id, room_id: params[:message][:room_id])
      # メッセージを新規作成
      @message = Message.create(params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: @current_user.id))
    else
      flash[:notice] = "メッセージ送信に失敗しました。"
    end
    redirect_to(room_path(@message.room_id))
  end

  def destroy
    # メッセージ情報を取得
    @message = Message.find_by(id: params[:id])
    if (@message.user_id == @current_user.id) && @message.destroy
      # メッセージの送信者がカレントユーザーの場合、メッセージを削除する
      flash[:notice] = "メッセージを削除いたしました。"
      redirect_to(room_path(@message.room_id))
    end
  end

end
