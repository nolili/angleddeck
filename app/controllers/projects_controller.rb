class ProjectsController < ApplicationController
  def create(project)
    @project = Project.new(project.permit(:name))
    if @project.save
      redirect_to project_url(@project.guid)
    else
      render :new
    end
  end

  def new
    @project = Project.new
  end

  def show(id)
    @project = Project.find(id)
  end
end
