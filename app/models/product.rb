class Product < ApplicationRecord
    belongs_to :user
    has_many :orders, dependent: :destroy
    has_many :users, through: :orders    
    has_many :feedbacks, dependent: :destroy

    validates :name, presence: true
    validates :category, presence: true
    validates :price, presence: true, numericality: { greater_than_or_equal_to: 20.0}
    validates :quantity, presence: true, numericality: { greater_than: 0}

    def create_order_history
      @order = Order.find_by(user_id: User.current.id, product_id: id)
      if @order != nil
        @order.update_attribute(:quantity, @order.quantity + 1)
      else
        @order = Order.create(quantity: 1, user_id: User.current.id, product_id: id)
        @order.save
      end
    end
end
