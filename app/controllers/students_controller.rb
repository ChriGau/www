class StudentsController < ApplicationController
  respond_to :html, :js

  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
    @statistics = @client.statistics
    @stories = @client.stories
    @stories =  Kaminari.paginate_array(@stories).page(params[:page]).per(4)
  end
end
