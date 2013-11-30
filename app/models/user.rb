class User < ActiveRecord::Base
  rolify
  has_secure_password
  before_create :ensure_auth_token

  def ensure_auth_token
  	self.auth_token ||= SecureRandom.hex(16)
  end
end
