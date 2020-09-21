class Style < ApplicationRecord

    acts_as_taggable

    attachment :image
    attachment :image_second
    attachment :image_third

    belongs_to :jenre
    belongs_to :user
    has_many :favorites, dependent: :destroy
	def favorited_by?(user)
       favorites.where(user_id: user.id).exists?
    end

    validates :name, presence: true, length: 2..20
    validates :content, presence: true, length: {maximum: 100}
    validates :price, length: {maximum: 10}
    validates :color_style, presence: true, length: {maximum: 20}
    validates :menu, presence: true, length: 2..25

    enum status: { MENS: 0, LADIES: 1 }

    def self.search(search)
       Style.joins(:user).where(['prefectures LIKE ? OR nickname LIKE ?', "%#{search}%", "%#{search}%"])
    end

end
