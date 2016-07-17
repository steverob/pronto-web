class RenameAccessTokenToGithubAccessTokenInUser < ActiveRecord::Migration[5.0]
  def change
    rename_column :users, :access_token, :github_access_token
  end
end
