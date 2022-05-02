class Product < ApplicationRecord
    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true, numericality: { greater_than: 20.0}
end
