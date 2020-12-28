class User < ApplicationRecord
    has_many :posts
    has_many :messages
    has_many :entries
    has_many :rooms, through: :entries
    has_many :likes, dependent: :destroy

    validates :user_id, {presence: true, uniqueness: true}
    validates :hdl_name, {presence: true}
    validates :password, {presence: true}

end
