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

get('/project/:id') do
  @projects = Project.find(params[:id])
  @projects = Project.all
  erb(:project_info)
end

get('/add_project') do
  @title = Project.find(params[:id])
  @projects = Project.all
  erb(:projects_home)
end

post('/add_project') do
  project = Project.new(params)
  projects.save
  @title = project.title
  @projects = Project.all
  erb(:projects_home)
end

delete('/delete_project/:id') do
  @projects = Project.find(params[:id])
  @projects.delete()
  @projects = Project.all()
  erb(:projects_home)
end

get('/volunteer/:id') do
  @volunteers = Project.find(params[:id])
  erb(:volunteer_info)
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


post('/delete_volunteer') do

  erb(:volunteer_info)
end
