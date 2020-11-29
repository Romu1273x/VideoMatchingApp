class ApplicationController < ActionController::Base
    before_action :set_current_user
    
    def set_current_user
        # カレントユーザーを取得
        @current_user = User.find_by(id: session[:id])
    end
end
