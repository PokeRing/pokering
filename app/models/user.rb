class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX

  def pin=(pin)
    self.pin_salt = BCrypt::Engine.generate_salt
    self.pin_encrypted= BCrypt::Engine.hash_secret(pin, self.pin_salt)
  end
end
