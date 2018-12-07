require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('./lib/**/*.rb')
require './lib/project'
require './lib/volunteer'

get ('/') do
  @projects = Project.all
  @volunteer = Volunteer.all
  erb(:projects_home)
end

post('/add_project') do
  project = Project.new(params)
  project.save
  @title = project.title
  @specialty_id = project.specialty_id
  @projects = Project.all
  erb(:projects_home)
end

post('/add_volunteer') do
  volunteer = Volunteer.new(params)
  volunteer.save
  @name = volunteer.name
  @project_id = volunteer.project_id
  @volunteer = Volunteer.all
  erb(:projects_home)
end

get('/details/:id') do
  @project = Project.find(params[:id])
  erb(:project_info)
end
