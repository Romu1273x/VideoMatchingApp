class User < ApplicationRecord
    validates :user_id, {presence: true, uniqueness: true}
    validates :hdl_name, {presence: true}
    validates :password, {presence: true}
end
