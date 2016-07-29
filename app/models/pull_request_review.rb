class PullRequestReview < ApplicationRecord
  belongs_to :project
  delegate :scm_service, to: :project

  def review    
    ProntoWeb.review_pull_request self
  end
end
