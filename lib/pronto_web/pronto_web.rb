module ProntoWeb
  def self.review_github_pull_request project:, pull_request_data:
    Github::Reviewer.new(
      project: project,
      pull_request_data: Github::PullRequest.new(pull_request_data)
    ).review
  end

  def self.review_gitlab_merge_request
    raise NotImplementedError
  end
end
