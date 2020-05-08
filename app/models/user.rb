class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :salons, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :boards_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy

  attachment :profile_image

  validates :name, presence: true, length: 2..20
  # user名前２から20文字いない
  validates :kana_name, presence: true, length: 2..20
  validates :nickname, presence: true, length: 2..20
  validates :prefectures, presence: true
  validates :body, length: {maximum: 100}
  # プロフィール文50文字いない
end
