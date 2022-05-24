require 'rails_helper'

RSpec.describe User, :type => :model do
    subject {
        create(:user)
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without name attribute" do
        subject.name = nil
        expect(subject).to_not be_valid
    end

    it "is not valid with wrong email format" do
        subject.email = "fake@gmail"
        expect(subject).to_not be_valid
    end

    it "is not valid with wrong password format" do
        subject.password = "test@123"
        expect(subject).to_not be_valid
    end

    it "is not valid with password mismatch" do
        subject.password = "tTest@123"
        expect(subject).to_not be_valid
    end

    it "is valid without mobile attribute" do
        subject.mobile = nil
        expect(subject).to be_valid
    end

    it "has unique email" do
        user = create(:user, email: "test@gmail.com")
        subject.email = "test@gmail.com"
        expect(subject).to_not be_valid
    end

    it "is not valid without valid mobile number" do
        subject.mobile = "90900099"
        expect(subject).to_not be_valid
    end

    it "has one wallet" do
        should have_one(:wallet)
    end

    it "has many products" do
        should have_many(:products)
    end

    it "has many orders with destroy dependency" do
        expect(subject).to have_many(:orders).dependent(:destroy)
    end

    it {should have_many(:ordered_products).through(:orders)}

    it {should have_many(:feedbacks)}

    it {should have_many(:liked_products).through(:likes)}

    it "should create wallet on create user" do
        expect(subject.wallet).to_not eq(nil)
    end
end