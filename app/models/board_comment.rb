class BoardComment < ApplicationRecord

	belongs_to :user
    belongs_to :board

    validates :comment, presence: true, length: 2..200
end
