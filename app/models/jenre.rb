class Jenre < ApplicationRecord

	has_many :styles, dependent: :destroy

    validates :name, presence: true, length: 2..20

end
