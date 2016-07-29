class User < ApplicationRecord
  has_many :projects
  validate :testing_custom_validator
 
  def testing_custom_validator
    errors.add(:access_token, "is not active")
  end

  def access_token_for scm_service:
    send "#{scm_service}_access_token"
  end
end
