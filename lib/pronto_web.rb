module ProntoWeb
    def self.call pull_request_review
      puts pull_request_review
    end

    def initialize pull_request_review
      @pull_request_review = pull_request_review
    end

    def review
      Reviewer.new "review_#{pull_request_review.scm_service}_pull_request",
                     project: pull_request_review.project,
                     pull_request_data: Github::PullRequest.new(pull_request_review.payload)
    end

    def review_github_pull_request project:, pull_request_data:
      Github::Reviewer.new(
        project: project,
        pull_request_data: Github::PullRequest.new(pull_request_data)
      ).review
    end

    def self.review_gitlab_merge_request
      raise NotImplementedError
    end
end
