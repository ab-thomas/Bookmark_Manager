require 'bcrypt'

class User 

  include DataMapper::Resource

  property :id, Serial
  property :email, String
  # this will store both the password and the salt
  property :password_digest, Text
  # when assigned the password, we don't store it directly
  # instead we generate a passwrod digest and save it to DB
  # The digest is provided by bcrypt, both password hash and salt
  # saved to DB instead of plain password for security reasons
  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

end