class Project < ApplicationRecord
  belongs_to :user
  has_many   :pull_request_reviews

  def access_token
    user.access_token_for scm_service: self.scm_service
  end

  def create_pull_request_review payload
    pull_request_reviews.create payload: payload
  end
end
