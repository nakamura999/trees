class Board < ApplicationRecord

	belongs_to :user
	has_many :board_comments, dependent: :destroy

	validates :title, presence: true, length: 2..30
	validates :content, presence: true, length: {maximum: 200}

end
