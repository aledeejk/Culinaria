class Post < ApplicationRecord
    has_many :comments
    validates :title, presence: true, length: {minimum: 5}

    belongs_to :user
    validates :title, presence: true
    validates :body, presence: true
end
