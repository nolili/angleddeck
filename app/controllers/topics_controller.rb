class TopicsController < ApplicationController
  def show(project_id, id)
    @project = Project.find(project_id)
    @topic = @project.topics.find(id)
  end

  def new(project_id)
    @project = Project.find(project_id)
    @topic = @project.topics.new
  end

  def create(project_id, topic)
    @project = Project.find(project_id)
    @topic = @project.topics.new(topic.permit(:name, :url))

    if @topic.save
      redirect_to project_topic_url(@project.guid, @topic.id)
    else
      render :new
    end
  end
end
