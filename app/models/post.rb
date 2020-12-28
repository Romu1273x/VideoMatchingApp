class Post < ApplicationRecord
    belongs_to :user
    has_many :likes, dependent: :destroy

    validates :user_id, {presence: true}
    validates :title, {presence: true}
    validates :select, {presence: true}
    validates :price, {presence: true}
    validates :period, {presence: true}
    validates :content, {presence: true, length: {maximum: 140}}

end
