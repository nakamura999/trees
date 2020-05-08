class Salon < ApplicationRecord

	belongs_to :user
	attachment :salon_image

    validates :salon_name, presence: true, length: 2..20
    validates :salon_address, length: {maximum: 40}
    validates :salon_phone, presence: true, length: 2..12
end
