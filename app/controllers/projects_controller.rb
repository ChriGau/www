class ProjectsController < ApplicationController
  def index
    @projects = @client.projects("alumni_projects")
    @statistics = @client.statistics
  end
end
