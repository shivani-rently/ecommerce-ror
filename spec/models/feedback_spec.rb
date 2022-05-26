require 'rails_helper'

RSpec.describe Feedback, :type => :model do
    subject {
        build(:feedback)
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without comment attribute" do
        subject.comment= nil
        expect(subject).to_not be_valid
    end

    it "is not valid without user id" do
        subject.user_id = nil
        expect(subject).to_not be_valid
    end

    it "is not valid without product id" do
        subject.product_id = nil
        expect(subject).to_not be_valid
    end

    it { should belong_to(:user) }

    it { should belong_to(:product) }
    
end