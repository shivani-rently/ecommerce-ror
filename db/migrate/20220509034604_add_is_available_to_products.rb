class AddIsAvailableToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :isAvailable, :boolean
  end
end
