class RoomsController < ApplicationController

  def index
    # DM相手のユーザー一覧を表示
    @rooms = @current_user.rooms
    @room_entres = Entry.where(room_id: @rooms).where.not(user_id: @current_user).order(created_at: :desc)
  end

  def create
    # 新規DMを作成。新規ルームとエントリーする2ユーザーを作成
    @room = Room.create
    @entry_current_user = Entry.create(user_id: @current_user.id, room_id: @room.id)
    @entry_user = Entry.create(params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id))
    # DMページを表示
    redirect_to(room_path(@room.id))
  end

  def show
    # DMの詳細を表示
    @room = Room.find_by(id: params[:id])
    if Entry.where(user_id: @current_user.id, room_id: @room.id)
      # メッセージ履歴を取得
      @messages = @room.messages.includes(:user).order(created_at: :desc)
      # メッセージを新規作成
      @message = Message.new
      # DM相手のユーザー名を取得
      entries = @room.entries
      opponent_user = entries.where.not(user_id: @current_user.id)
      @opponent_user_name = opponent_user[0].user.hdl_name
    else
      # 直前のページを表示
      redirect_back(fallback_location: root_path)
    end
  end

end
