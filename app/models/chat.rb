class Chat < ApplicationRecord

  belongs_to :user
  belongs_to :room

  validates :content, presence: true, length: 2..100

end
