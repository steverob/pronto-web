class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session
  
  def github_pr
    github_project(params).create_pull_request_review params
    head :ok
  end

  private

  def github_project payload
    Project.find_by external_id: payload['pull_request']['repo']['id']
  end
end