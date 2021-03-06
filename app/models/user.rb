class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  # 登録メール機能
  after_create :send_welcome_mail

  # 論理削除
  acts_as_paranoid

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :salons, dependent: :destroy
  has_many :styles, dependent: :destroy
  has_many :boards, dependent: :destroy
  has_many :board_comments, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorites_styles, through: :favorites, source: :style
  has_many :chats, dependent: :destroy
  has_many :user_rooms, dependent: :destroy
  has_many :rooms, through: :user_rooms

  attachment :profile_image

  validates :name, presence: true, length: 2..20
  # user名前２から20文字いない
  validates :kana_name, presence: true, length: 2..20
  validates :nickname, presence: true, length: 2..20
  validates :prefectures, presence: true, length: 2..5
  validates :body, length: {maximum: 100}
  # プロフィール文50文字いない
  validates :email, presence: true

  enum status: { 一般: 0, 美容師: 1 }


  has_many :follower, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォロー取得
  has_many :followed, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォロワー取得
  has_many :following_user, through: :follower, source: :followed
  # 自分がフォローしている人
  has_many :follower_user, through: :followed, source: :follower
  # 自分をフォローしている人

  def follow(user_id)
    follower.create(followed_id: user_id)
  end

  # ユーザーのフォローを外す
  def unfollow(user_id)
    follower.find_by(followed_id: user_id).destroy
  end

  # フォローしていればtrueを返す
  def following?(user)
    following_user.include?(user)
  end

  # ユーザ登録後にメールを送信する処理
  def send_welcome_mail
    UserMailer.user_welcome_mail(self).deliver
  end

  def self.search(search)
      where(['nickname LIKE ?', "%#{search}%"])
  end

end
