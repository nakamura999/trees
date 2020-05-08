class Board < ApplicationRecord

	belongs_to :user
	has_many :board_comments, dependent: :destroy

	validates :title, presence: true
	validates :content, presence: true, length: {maximum: 200}

end
