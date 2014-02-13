require 'bcrypt'

class User 

  include DataMapper::Resource

  property :id, Serial
  property :email, String, :unique => true, :message => 
  "This email is already taken"
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

  def self.authenticate(email, password)
    # that's the suer who is trying to sign in
    user = first(:email => email)
    # If the user exists and the password provided matches the one we have 
    # password_digest for, everything's fine. 
    # The Password.new returns an object that overrides the == method. 
    # Instead of comparing two passwords directly (which is impossible because
    # we only have a one-way hash)
    # The == method calulates the candidate password_digest from the password 
    # given and compares it to the password_digest it was initialised with. 
    # So, to recap: THIS IS NOT A STRING COMPARISON
    if user && BCrypt::Password.new(user.password_digest) == password
      # return the user
      user
    else
      nil
    end
  end
 
end