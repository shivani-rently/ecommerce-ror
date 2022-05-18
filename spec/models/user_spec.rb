require 'rails_helper'

RSpec.describe User, :type => :model do
    it "is valid with valid attributes" do
        expect(User.new(name: "Tester", email: "test@gmail.com", password: "Test@123", mobile: "1902348990", password_confirmation: "Test@123")).to be_valid
    end

    it "is not valid without name attribute" do
        expect(User.new(email: "test@gmail.com", password: "Test@123", mobile: "1902348990", password_confirmation: "Test@123")).to_not be_valid
    end

    it "is not valid with wrong email format" do
        expect(User.new(name: "Tester", email: "test@gmail", password: "Test@123", mobile: "1902348990", password_confirmation: "Test@123")).to_not be_valid
    end

    it "is not valid with wrong password format" do
        expect(User.new(name: "Tester", email: "test@gmail.com", password: "Test@123", mobile: "1902348990", password_confirmation: "test@123")).to_not be_valid
    end

    it "is not valid with password mismatch" do
        expect(User.new(name: "Tester", email: "test@gmail.com", password: "Test@123", mobile: "1902348990", password_confirmation: "test@1234")).to_not be_valid
    end

    it "is valid without mobile attribute" do
        expect(User.new(name: "Tester", email: "test@gmail.com", password: "Test@123", password_confirmation: "Test@123")).to be_valid
    end

end