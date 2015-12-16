class Category < ActiveRecord::Base
  before_save :downcase_fields
  has_and_belongs_to_many :products
  validates :name, presence: true, uniqueness: true

  def downcase_fields
    self.name.downcase!
  end
end
