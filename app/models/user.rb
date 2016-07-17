class User < ApplicationRecord
  has_many :projects

  def access_token_for scm_service:
    send "#{scm_service}_access_token"
  end
end
