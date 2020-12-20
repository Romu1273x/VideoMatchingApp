class Post < ApplicationRecord
    has_many :likes, dependent: :destroy

    validates :user_id, {presence: true}
    validates :title, {presence: true}
    validates :select, {presence: true}
    validates :price, {presence: true}
    validates :period, {presence: true}
    validates :content, {presence: true, length: {maximum: 140}}

    def user
        # 投稿したユーザー情報を取得
        return User.find_by(user_id: self.user_id)
    end
end
