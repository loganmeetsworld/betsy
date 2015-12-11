class Robot < ActiveRecord::Base
  has_many :products

  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password
end
