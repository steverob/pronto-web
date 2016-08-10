class PullRequestReview < ApplicationRecord
  belongs_to :project
  delegate   :scm_service, to: :project
  serialize  :payload, ActiveRecord::Coders::NestedHstore

  def review
    ProntoWeb::Reviewer.new(self).send "review_#{scm_service}_pull_request"
  end
end
