class Book < ApplicationRecord
    has_many :reserves  
    has_many :users, through: :reserves

    scope :books_for_me, -> (user) { Reserve.where(user_id: user.id)}
end
