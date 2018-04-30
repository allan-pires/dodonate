class User < ApplicationRecord  
  has_many :items

  before_save { self.email = email.downcase }

  validates :name, 
  	presence: true, 
  	length: { maximum: 255 }
  
  validates :email, 
  	presence: true, 
  	length: { maximum: 255 }, 
  	format: { with: UsersHelper.email_regex }, 
  	uniqueness: { case_sensitive: false }

  validates :password, 
  	presence: true, 
  	length: { minimum: 6 }

  has_secure_password
end
