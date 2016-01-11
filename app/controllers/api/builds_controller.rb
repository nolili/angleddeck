class Api::BuildsController < ApplicationController
  skip_before_action :verify_authenticity_token
  before_action :reject_if_not_json_request

  J = StrongJSON.new do
    let :build, object(name: string, url: string, bundle_version: string, bundle_identifier: string)
    let :build_request, object(topic_url: string?, build: build)
  end

  def create(project_id)
    project = Project.find(project_id)

    json = posted_json(as: J.build_request)

    topic_url = json[:topic_url]
    build_attributes = json[:build]

    if topic_url
      topic = project.topics.find_or_create_by!(url: topic_url) do |topic|
        topic.name = topic_url
      end
    else
      topic = project.topics.where(name: nil, url: nil).first
    end

    topic.builds.create!(build_attributes)

    render status: :ok, json: []
  end
end
