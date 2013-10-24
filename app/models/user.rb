require 'bcrypt'

class User 
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  include Mongoid::Document

  field :first_name, type: String
  field :last_name, type: String
  field :email, type: String
  field :salt, type: String
  field :hashed_password, type: String

  before_save :hash_password
  validates :email, presence: true
  validates_presence_of :name
  validates_uniqueness_of :name, :email, :case_sensitive => false

  attr_accessor :password, :password_confirmation

 def authenticate(password)
  self.hashed_password ==
  BCrypt::Engine.hash_secret(password, self.salt)
 end

 private

 def hash_password
  if password.present?
    self.salt = BCrypt::Engine.generate_salt
    self.hashed_password = 
    BCrypt::Engine.hash_secret(password, self.salt)
    password = password_confirmation = nil
  end
 end

end
