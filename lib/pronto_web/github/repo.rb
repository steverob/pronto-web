module ProntoWeb
  module Github
    class Repo
      def initialize project:
        @project = project
      end

      def repo_path
        @repo_path ||= begin 
          Rails.root.join("tmp/repos/#{@project.slug}/#{SecureRandom.hex}").tap do |path|
            FileUtils.mkdir_p path
          end.to_s
        end
      end

      def prepare_repo_for_review! pull_request
        clone_and_fetch_branch! pull_request
        generate_pronto_config_file!
      end

      def cleanup!
        FileUtils.rm_rf repo_path
      end

      private

      def clone_and_fetch_branch! pull_request
        Rugged::Repository.clone_at(
          pull_request.ssh_url,
          repo_path,
          checkout_branch: pull_request.base_ref,
          credentials: credentials
        ).tap do |repo|
          repo.fetch 'origin', pull_request.head_ref, credentials: credentials
          repo.create_branch pull_request.head_ref, "origin/#{pull_request.head_ref}"
          repo.checkout pull_request.head_ref
        end
      end

      def generate_pronto_config_file!
        config_path = "#{repo_path}/.pronto.yml"
        config = (File.exist?(config_path) ? (YAML.load_file(config_path) || {}) : {}).tap do |c|
                    c.merge!('github' => {
                                'slug' => @project.slug,
                                'access_token' => @project.access_token
                            })
                  end
        File.open(config_path, 'w') do |f|
          f.write config.to_yaml
        end
      end

      def credentials
        credentials ||= Rugged::Credentials::SshKey.new(
                          username: 'git',
                          publickey: File.expand_path(".ssh/id_rsa.pub"), 
                          privatekey: File.expand_path(".ssh/id_rsa")
                        )
      end
    end
  end
end