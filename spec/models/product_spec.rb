require 'rails_helper'

RSpec.describe Product, :type => :model do
    before(:all) do
        @user = User.find(1)
    end
    it "is valid with valid attributes" do
        expect(Product.new(name: "Testing Product", category: "test category", price: 20.0, quantity: 3, user_id: @user.id, isAvailable: true, status: true)).to be_valid
    end

    it "is not valid without name attribute" do
        expect(Product.new(category: "test category", price: 20.0, quantity: 3, user_id: @user.id, isAvailable: true, status: true)).to_not be_valid
    end

    it "is not valid without category attribute" do
        expect(Product.new(name: "Testing Product", price: 20.0, quantity: 3, user_id: @user.id, isAvailable: true, status: true)).to_not be_valid
    end

    it "is not valid without price attribute" do
        expect(Product.new(name: "Testing Product", category: "test category", quantity: 3, user_id: @user.id, isAvailable: true, status: true)).to_not be_valid
    end

    it "is not valid without invalid price" do
        expect(Product.new(name: "Testing Product", category: "test category", price: 10.0, quantity: 3, user_id: @user.id, isAvailable: true, status: true)).to_not be_valid
    end

    it "is not valid without quantity attribute" do
        expect(Product.new(name: "Testing Product", category: "test category", price: 20.0, user_id: @user.id, isAvailable: true, status: true)).to_not be_valid
    end

    it "is not valid without invalid quantity" do
        expect(Product.new(name: "Testing Product", category: "test category", price: 20.0, quantity: 0, user_id: @user.id, isAvailable: true, status: true)).to_not be_valid
    end
end