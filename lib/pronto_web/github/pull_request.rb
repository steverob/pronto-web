module ProntoWeb
  module Github
    class PullRequest
      def initialize attributes
        @attributes = attributes
      end

      def head_ref
        @attributes['pull_request']['head']['ref']
      end

      def base_ref
        @attributes['pull_request']['base']['ref']
      end

      def ssh_url
        @attributes['repository']['ssh_url']
      end
    end
  end
end