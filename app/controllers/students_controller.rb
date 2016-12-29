class StudentsController < ApplicationController
  respond_to :html, :js

  def index
    @testimonials = @client.testimonials(locale.to_s)
    @projects = @client.projects("alumni_projects")
    @statistics = @client.statistics
    @stories = @client.stories
    @stories =  Kaminari.paginate_array(@stories).page(params[:page]).per(4)
  end

  def reviews_counter
    require 'open-uri'

    html_coursereport = Nokogiri::HTML(open("https://www.coursereport.com/schools/le-wagon#/reviews"))
    coursereport_data = html_coursereport.search('#reviews_tab').text
    coursereport_data = coursereport_data.split(//).map {|x| x[/\d+/]}.compact.join("").to_i

    html_switchup = Nokogiri::HTML(open("https://www.switchup.org/bootcamps/le-wagon"))
    switchup_data = html_switchup.search('.bootcamp-caption').text
    switchup_data = switchup_data.gsub(/[^\d]/, '')
    switchup_data = switchup_data.split(//).to_a.drop(2).join.to_i

    @reviews_counter = coursereport_data + switchup_data
  end
end
