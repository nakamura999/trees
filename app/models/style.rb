class Style < ApplicationRecord

	acts_as_taggable

	belongs_to :jenre
	belongs_to :user
	has_many :favorites, dependent: :destroy
	def favorited_by?(user)
       favorites.where(user_id: user.id).exists?
    end

    attachment :image

    validates :name, presence: true, length: 2..20
    validates :content, length: {maximum: 100}
    validates :price, length: {maximum: 10}
end
