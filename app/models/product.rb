class Product < ApplicationRecord
    belongs_to :user
    has_many :orders
    has_many :users, through: :orders    
    has_many :feedbacks
    has_many :likes, dependent: :destroy
    has_many :liked_users, through: :likes, source: :user

    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 20.0}
    validates :quantity, presence: true, numericality: { greater_than: 0}, on: :create

    scope :with_less_price, -> {where("price < 50.0")}
end
