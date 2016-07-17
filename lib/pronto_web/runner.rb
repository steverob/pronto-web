module ProntoWeb
  class Runner
    def initialize runnable
      @runnable = runnable
    end

    def run
      Dir.chdir runnable.code_path do
        ::Pronto.run(
          runnable.diff_commit, 
          runnable.code_path, 
          runnable.formatters
        )
      end
    end

    private

    attr_reader :runnable
  end
end