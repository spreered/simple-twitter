class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  mount_uploader :avatar, AvatarUploader

  has_many :tweets
  #使用者可以有很多tweet

  has_many :replies, dependent: :destroy
  #刪掉user 就會刪掉relies
  has_many :likes, dependent: :destroy
  #刪掉user 就會刪掉likes
  has_many :liked_tweets, through: :likes, source: :tweet

  has_many :followeships, dependent: :destroy
  #追蹤關係
  has_many :followings, through: :followeships
  #追縱對象

  # 需要 app/views/devise 裡找到樣板，加上 name 屬性
  # 並參考 Devise 文件自訂表單後通過 Strong Parameters 的方法
  validates_presence_of :name
  # 加上驗證 name 不能重覆 (關鍵字提示: uniqueness)
  validates_uniqueness_of :name

  def admin?
    self.role=='admin'
  end
  


end
