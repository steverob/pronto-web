class Project < ApplicationRecord
  belongs_to :user

  def access_token
    user.access_token_for scm_service: self.scm_service
  end
end
