class Product < ApplicationRecord
    belongs_to :user
    has_many :orders
    has_many :users, through: :orders    
    has_many :feedbacks

    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 20.0}
    validates :quantity, presence: true, numericality: { greater_than: 0}, on: :create
end
