class ApplicationController < ActionController::Base
    before_action :set_current_user
    
    def set_current_user
        # カレントユーザーを取得
        @current_user = User.find_by(id: session[:id])
    end

    def authenticate_user
        # 非ログインユーザーに制限をかける
        if @current_user == nil
            flash[:notice] = "ログインが必要です"
            redirect_to("/login")
        end
    end

    def forbid_login_user
        # ログイン済ユーザーに制限をかける
        if @current_user
            flash[:notice] = "すでにログインしています"
            redirect_to("/posts/index")
        end
    end

end
