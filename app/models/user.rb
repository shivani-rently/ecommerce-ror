class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  
  PASSWORD_FORMAT = /\A(?=.{6,})(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[[:^alnum:]])/x
  EMAIL_FORMAT = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
  MOBILE_FORMAT = /\d[0-9]\)*\z/

  after_commit :create_wallet, on: :create

  has_many :products
  has_one :wallet
  has_many :orders, dependent: :destroy
  has_many :ordered_products, through:  :orders, source:  :product
  has_many :likes, dependent: :destroy
  has_many :liked_products, through: :likes, source: :product

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :ordered_products, through:  :orders, source:  :product
  has_many :feedbacks
  validates :name, presence: true, length: { maximum: 20 }
  validates :email, presence: true, format: { with: EMAIL_FORMAT }
  validates :password, presence: true, format: { with: PASSWORD_FORMAT }
  validates :mobile, format: { with: MOBILE_FORMAT }, length: { minimum: 10, maximum: 10 }, allow_blank: true


  def create_wallet
    @wallet = Wallet.create(coins: 2000.0, user_id: id)
  end

  def self.authenticate(email, password)
    user = User.find_for_authentication(email: email)
    user&.valid_password?(password) ? user : nil
  end
end
