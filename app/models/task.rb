class Task < ApplicationRecord
  validates :content, presence: true, length: { minimum: 1, maximum: 255 }
  validates :status, presence: true, length: { minimum: 1, maximum: 10 }
end
