require 'rails_helper'

RSpec.describe Feedback, :type => :model do
    it "is valid with valid attributes" do
        feedback = create(:feedback)
        expect(feedback).to be_valid
    end

    it "is not valid without comment attribute" do
        feedback = build(:feedback, comment: nil)
        expect(feedback).to_not be_valid
    end

    it "is not valid without user id" do
        feedback = build(:feedback, user_id: nil)
        expect(feedback).to_not be_valid
    end

    it "is not valid without product id" do
        feedback = build(:feedback, product: nil)
        expect(feedback).to_not be_valid
    end
end