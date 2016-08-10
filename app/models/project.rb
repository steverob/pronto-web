class Project < ApplicationRecord
  belongs_to :user
  has_many   :pull_request_reviews

  def access_token
    user.access_token_for scm_service: self.scm_service
  end

  def create_pr_review payload
    pr = pull_request_reviews.create payload: payload.to_h
    ReviewJob.perform_later pr.id
  end
end