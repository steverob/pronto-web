class ReviewJob < ApplicationJob
  queue_as :default

  def perform pr_review_id
    PullRequestReview.find(pr_review_id).review
  end
end