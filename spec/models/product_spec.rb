require 'rails_helper'

RSpec.describe Product, type: :model do
  let(:good_product) { build :product, name: nil }
  let(:bad_product) { build :product, name: "Test" }

  describe "validations" do 
    it "has a user id" do 
      expect(good_product).to be_valid
      expect(bad_product).to_not be_valid
    end

    it "has a name" do
      expect(good_product).to be_valid
      expect(bad_product).to_not be_valid
      expect(bad_product.errors.keys).to include(:name)
    end
  end
end
