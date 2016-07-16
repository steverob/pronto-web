module ProntoWeb
  class Runnable
    attr_accessor :diff_commit, :formatters, :code_path

    def initialize diff_commit: nil, formatters: nil, path_to_code: '.'
      @diff_commit = diff_commit
      @formatters  = formatters
      @code_path   = File.expand_path path_to_code
    end
  end
end