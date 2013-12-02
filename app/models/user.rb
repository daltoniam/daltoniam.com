class User < ActiveRecord::Base
  rolify
  has_secure_password
  before_create :ensure_auth_token
  has_many :comments

  validates :name, presence: true, uniqueness: true, format: /\A[a-z0-9_-]+\z/i
  validates :email, presence: true, uniqueness: true, format: /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/

  def ensure_auth_token
  	self.auth_token ||= SecureRandom.hex(16)
  end
end
