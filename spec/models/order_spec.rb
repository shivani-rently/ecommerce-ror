require 'rails_helper'

RSpec.describe Order, :type => :model do
    subject {
        build(:order)
    }

    it "is valid with valid attributes" do
        expect(subject).to be_valid
    end

    it "is not valid without quantity attribute" do
        subject.quantity = nil
        expect(subject).to_not be_valid
    end

    it "is not valid for quantity <= 0" do
        subject.quantity = 0
        expect(subject).to_not be_valid
    end

    it { should belong_to(:user) }

    it { should belong_to(:product) }
end