module ProntoWeb
  class Reviewer  
    def initialize pull_request_review
      @pull_request_review = pull_request_review
    end

    def review_github_pull_request
      Github::Reviewer.new(
        project: @pull_request_review.project,
        pull_request: Github::PullRequest.new(@pull_request_review.payload)
      ).review
    end

    def self.review_gitlab_merge_request
      raise NotImplementedError
    end
  end
end
