class Projects::HooksController < ApplicationController
  def github(project_id)
    project = Project.find(project_id)

    ApplicationRecord.transaction do
      hook.GithubHook.new(project: project, request: request)
      hook.run!
    end

    render status: :ok, json: []
  end
end

