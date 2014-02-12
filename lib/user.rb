require 'bcrypt'

class User 

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true
  # this will store both the password and the salt
  property :password_digest, Text

  # We need reader for :password and :password_confirmation so can datamapper
  # can have access to both values to make sure they're the same
  attr_reader :password
  # We need writer for :password_confirmation to pass it to the model in the controller
  attr_accessor :password_confirmation
  # this is datamapper's method of validating the model.
  # The model will not be saved unless both password
  # and password_confirmation are the same
  # read more about it in the documentation
  # http://datamapper.org/docs/validations.html
  validates_confirmation_of :password
  validates_uniqueness_of :email
  # when assigned the password, we don't store it directly
  # instead we generate a passwrod digest and save it to DB
  # The digest is provided by bcrypt, both password hash and salt
  # saved to DB instead of plain password for security reasons
  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end