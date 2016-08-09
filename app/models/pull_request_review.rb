class PullRequestReview < ApplicationRecord
  belongs_to :project
  delegate :scm_service, to: :project

  def review
    ProntoWeb.new(self).send "review_#{scm_service}_pull_request"
  end
end
