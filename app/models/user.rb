class User < ApplicationRecord
  has_secure_password

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :password, length: { minimum: 6 }

  # Define the custom authentication method
  def self.authenticate_with_credentials(email, password)
    # Find the user by email, case insensitive
    user = User.find_by('LOWER(email) = ?', email.downcase.strip)
    
    # Check if the password matches
    user && user.authenticate(password) ? user : nil
  end
end
