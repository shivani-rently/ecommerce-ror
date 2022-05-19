require 'rails_helper'

RSpec.describe User, :type => :model do
    it "is valid with valid attributes" do
        user = create(:user)
        expect(user).to be_valid
    end

    it "is not valid without name attribute" do
        user = build(:user, name: nil)
        expect(user).to_not be_valid
    end

    it "is not valid with wrong email format" do
        user = build(:user, email: "fake@gmail")
        expect(user).to_not be_valid
    end

    it "is not valid with wrong password format" do
        user = build(:user, password: 'test@123')
        expect(user).to_not be_valid
    end

    it "is not valid with password mismatch" do
        user = build(:user, password: 'tTest@123')
        expect(user).to_not be_valid
    end

    it "is valid without mobile attribute" do
        user = create(:user, mobile: nil)
        expect(user).to be_valid
    end

    it "has unique email" do
        user = build(:user, email: "test@gmail.com")
        expect(user).to_not be_valid
    end

    it "is not valid without valid mobile number" do
        user = build(:user, mobile: "90900099")
        expect(user).to_not be_valid
    end

end