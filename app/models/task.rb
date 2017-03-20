class Task < ApplicationRecord
  validates :content, presence: true, length: {minimum: 4, maximum: 500}

  belongs_to :user
end