require 'rails_helper'

RSpec.describe Category, type: :model do
  describe "validations" do
    it "raises an error when name was missing" do
      bad_category = build(:category, name: nil)
      expect(bad_category).to_not be_valid
      expect(bad_category.errors.keys).to include(:name)
    end

    it "refuses to create category with same name" do
      create(:category)
      nope = build(:category)
      expect(nope).to be_invalid
    end
  end
end
