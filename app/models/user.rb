class User < ActiveRecord::Base
  # Remember to create a migration!

  validates :username, presence: true
  validates :email, uniqueness: true
   validates :password_digest, uniqueness: true

  has_secure_password
end


  #  # e.g., User.authenticate('jesse@devbootcamp.com', 'apples123')
  #  def self.authenticate(email, password)
  #   # if email and password correspond to a valid user, return that user
  #   if self.email == email && self.password == password
  #     self
  #   else
  #     nil
  #   end
  # end

  # def password
  #   @password ||= Password.new(password_hash)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   self.password_hash = @password
  # end
