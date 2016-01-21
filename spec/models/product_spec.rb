require 'rails_helper'

RSpec.describe Product, type: :model do
  before :each do
    @good_product = Product.create(name: 'product', price: 10, robot_id: 1, stock: 1)
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:robot_id) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:length) }
    it { is_expected.to validate_presence_of(:width) }
    it { is_expected.to validate_presence_of(:height) }
    it { is_expected.to validate_presence_of(:weight) }
    it { is_expected.to validate_numericality_of(:price).is_greater_than(0)}
    it { is_expected.to validate_numericality_of(:stock).is_greater_than_or_equal_to(0)}
    it { is_expected.to validate_numericality_of(:length).is_greater_than(0).is_less_than_or_equal_to(108) }
    it { is_expected.to validate_numericality_of(:width).is_greater_than(0).is_less_than_or_equal_to(165) }
    it { is_expected.to validate_numericality_of(:height).is_greater_than(0).is_less_than_or_equal_to(165) }
    it { is_expected.to validate_numericality_of(:weight).is_greater_than(0).is_less_than_or_equal_to(150) }
  end

  describe "model methods" do
    it "averages the rating correctly" do
      Review.create(rating: 4, product_id: @good_product.id)
      Review.create(rating: 3, product_id: @good_product.id)
      Review.create(rating: 3, product_id: @good_product.id)
      Review.create(rating: 3, product_id: @good_product.id)

      expect(@good_product.rating_average).to eq 3
    end

    it "shows categories correctly" do
      @cat1 = Category.create(name: "cat1")
      @cat2 = Category.create(name: "cat2")
      @cat3 = Category.create(name: "cat3")
      @cat4 = Category.create(name: "cat4")

      Product.find(@good_product.id).categories << Category.find(@cat1.id)
      Product.find(@good_product.id).categories << Category.find(@cat2.id)
      Product.find(@good_product.id).categories << Category.find(@cat3.id)
      Product.find(@good_product.id).categories << Category.find(@cat4.id)

      expect(@good_product.show_categories).to eq "Cat1, Cat2, Cat3, Cat4"
    end

    it "searches products and descriptions for a word" do
      expect(Product.search("product").name).to eq (@good_product.name.titlecase)
    end
  end
end
