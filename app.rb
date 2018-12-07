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

get('/details/:id') do
  @projects = Project.find(params[:id])
  @volunteer = Project.find(params[:id])
  erb(:project_info)
end

get('/add_project') do
  @title = Project.find(params[:id])
  @projects = Project.all
  erb(:projects_home)
end

post('/add_project') do
  project = Project.new(params)
  @title = project.title
  @projects = Project.all
  project.save
  erb(:projects_home)
end

get('/add_volunteer') do
  @name = Volunteer.find(params[:id])
  @volunteer = Volunteer.all
  erb(:volunteer_info)
end

post('/add_volunteer') do
  volunteer = Volunteer.new(params)
  @name = volunteer.name
  @volunteer = Volunteer.all
  volunteer.save
  erb(:volunteer_info)
end
