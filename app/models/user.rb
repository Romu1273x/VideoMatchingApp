class User < ApplicationRecord
    has_many :messages
    has_many :entries
    has_many :rooms, through: :entries

    validates :user_id, {presence: true, uniqueness: true}
    validates :hdl_name, {presence: true}
    validates :password, {presence: true}

    def posts
        # ユーザーの投稿情報を取得
        return Post.where(user_id: self.user_id)
    end
end
