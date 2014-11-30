class User < ActiveRecord::Base
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
  validates :email, :presence => true, :uniqueness => true, :format => EMAIL_REGEX
  has_secure_password

  def self.get_queryable_fields
    ['first_name', 'last_name', 'email', 'username', 'bio', 'city', 'state']
  end

end
