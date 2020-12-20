class Post < ApplicationRecord
  belongs_to :user

  validates :body, presence: true, length: { in: 1..360 }
end
