require 'rails_helper'

RSpec.describe Product, :type => :model do
    it "is valid with valid attributes" do
        product = create(:product)
        expect(product).to be_valid
    end

    it "is not valid without name attribute" do
        product = build(:product, name: nil)
        expect(product).to_not be_valid
    end

    it "is not valid without category attribute" do
        product = build(:product, category: nil)
        expect(product).to_not be_valid
    end

    it "is not valid without price attribute" do
        product = build(:product, price: nil)
        expect(product).to_not be_valid
    end

    it "is not valid without invalid price" do
        product = build(:product, price: 10.0)
        expect(product).to_not be_valid
    end

    it "is not valid without quantity attribute" do
        product = build(:product, quantity: nil)
        expect(product).to_not be_valid
    end

    it "is not valid without invalid quantity" do
        product = build(:product, quantity: 0)
        expect(product).to_not be_valid
    end
end