class Project
  attr_accessor :slug, :access_token

  def initialize slug:, access_token:
    @slug         = slug
    @access_token = access_token
  end

  def scm_host
    'github'
  end
end