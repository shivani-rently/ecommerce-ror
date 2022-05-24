require 'rails_helper'

RSpec.describe Product, :type => :model do
    subject {
        create(:product)
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without name attribute" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without category attribute" do
        subject.category = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without price attribute" do
        subject.price = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without invalid price" do
        subject.price = 10.0
        expect(subject).to_not be_valid
    end

    it "is not valid without quantity attribute" do
        product = build(:product, quantity: nil)
        expect(product).to_not be_valid
    end

    it "is not valid without invalid quantity" do
        subject.quantity = 0
        expect(subject).to_not be_valid
    end

    it { should belong_to(:user) }

    it { should have_many(:orders) }

    it { should have_many(:users).through(:orders) }

    it { should have_many(:feedbacks) }

    it { should have_many(:likes) }

    it { should have_many(:liked_users).through(:likes) }
end