PASSWORD_FORMAT = /\A(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x
EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  after_commit :create_wallet, on: :create
  has_many :products
  has_one :wallet
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: EMAIL_FORMAT }
  validates :password, presence: true, format: { with: PASSWORD_FORMAT }

  def create_wallet
    @wallet = Wallet.create(coins: 2000.0, user_id: id)
  end
end
