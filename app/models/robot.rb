class Robot < ActiveRecord::Base
  has_many :products
  has_many :orderitems, :through => :products


  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: /@/
  validates :username, presence: true, uniqueness: { case_sensitive: false }

  has_secure_password

  # def self.authenticate(email, password)
  #   robot = find_by_email(email)
  #   if robot && robot.password_digest == BCrypt::Engine.hash_secret(password, robot.password_salt)
  #     robot
  #   else
  #     nil
  #   end
  # end

  # def encrypt_password
  #   if password.present?
  #     self.password_salt = BCrypt::Engine.generate_salt
  #     self.password_digest = BCrypt::Engine.hash_secret(password, password_salt)
  #   end
  # end
end
