module ProntoWeb
  module Github
    class Reviewer
      def initialize project:, pull_request:
        @project = project
        @pull_request = pull_request
      end

      def review
        prepare_repo!
        perform_review build_runnable
        cleanup_repo!
      end

      private

      def perform_review runnable
        ProntoWeb::Runner.new(@project, runnable).run
      end

      def build_runnable
        ProntoWeb::Runnable.new(
          diff_commit: @pull_request.base_ref,
          formatters: [Pronto::Formatter::GithubPullRequestFormatter.new],
          path_to_code: repo.repo_path
        )
      end

      def prepare_repo!
        repo.prepare_repo_for_review! @pull_request
      end

      def cleanup_repo!
        repo.cleanup!
      end

      def repo
        @repo ||= Repo.new(project: @project)
      end
    end
  end
end