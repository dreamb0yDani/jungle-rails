class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :password, length: {minimum: 8}
  validates :email, uniqueness: { case_sensitive: false }
  before_validation :email_downcase

  def email_downcase 
    self.email = email.downcase.strip if email.present?
  end

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)
    if @user && @user.authenticate(password)
      @user
    else
      nil
    end
  end
end
