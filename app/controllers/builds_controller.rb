class BuildsController < ApplicationController
  def show(project_id, topic_id, id)
    @project = Project.find(project_id)
    @topic = @project.topics.find(topic_id)
    @build = @topic.builds.find(id)
  end

  def new(project_id, topic_id)
    @project = Project.find(project_id)
    @topic = @project.topics.find(topic_id)
    @build = @topic.builds.new
  end

  def create(project_id, topic_id, build)
    @project = Project.find(project_id)
    @topic = @project.topics.find(topic_id)
    @build = @topic.builds.new(build.permit(:url, :bundle_version, :bundle_identifier, :name))

    if @build.save
      redirect_to project_topic_build_url(@project.guid, @topic.id, @build.id)
    else
      render :new
    end
  end

  def plist(project_id, topic_id, build_id)
    @project = Project.find(project_id)
    @topic = @project.topics.find(topic_id)
    @build = @topic.builds.find(build_id)
  end
end
