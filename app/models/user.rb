class User < ApplicationRecord
    validates :user_id, {presence: true, uniqueness: true}
    validates :hdl_name, {presence: true}
    validates :password, {presence: true}

    def posts
        # ユーザーの投稿情報を取得
        return Post.where(user_id: self.user_id)
    end
end
