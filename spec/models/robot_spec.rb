require 'rails_helper'

RSpec.describe Robot, type: :model do
  let(:orderitem) { create(:orderitem) }
  let(:robot) { orderitem.product.robot }

  describe "validations" do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_presence_of(:state) }
    it { is_expected.to validate_presence_of(:country) }
    it { is_expected.to validate_presence_of(:postal_code) }
    it { is_expected.to validate_length_of(:state) }
    it { is_expected.to validate_length_of(:country) }
    it { is_expected.to validate_length_of(:postal_code) }
    it { is_expected.to have_secure_password }
  end

  describe "revenue method" do
    it "calculates the revenue" do
      expect(robot.revenue).to eq 40.0
    end
  end
end
