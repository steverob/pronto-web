class WebhooksController < ApplicationController
  protect_from_forgery with: :null_session
  
  def github_pr
    github_project.create_pr_review(params.permit!) if handle_pr_action?
    head :ok
  end

  private

  def handle_pr_action?
    params["action"] == "opened" ||
    params["action"] == "synchronize"
  end

  def github_project
    Project.find_by external_id: params["repository"]["id"]
  end
end