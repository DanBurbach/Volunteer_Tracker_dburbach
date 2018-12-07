require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('./lib/**/*.rb')
require './lib/project'
require './lib/volunteer'

get ('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects_home)
end

get('/project/:id') do
  @projects = Project.find(params[:id])
  @projects = Project.all
  erb(:project_info)
end

get("/project/:id/edit") do
  @project = Project.find(params[:id])
  erb(:project_info)
end

patch("/project/:id") do
  title = params.fetch("title")
  @project = Project.find(params[:id])
  @project.update({:title => title})
  erb(:project_info)
end

delete('/delete_project/:id') do
  project = Project.find(params[:id])
  project.delete()
  @projects = Project.all()
  erb(:projects_home)
end

get('/add_project') do
  @title = Project.find(params[:id])
  @projects = Project.all
  erb(:projects_home)
end

post('/add_project') do
  project = Project.new(params)
  project.save
  @title = project.title
  @projects = Project.all
  erb(:projects_home)
end

get('/volunteer/:id') do
  @volunteers = Project.find(params[:id])
  erb(:volunteer_info)
end

get('/add_volunteer') do
  @volunteers = Volunteer.all
  erb(:volunteer_info)
end

post('/add_volunteer') do
  volunteer = Volunteer.new(params)
  @name = volunteer.name
  @volunteers = Volunteer.all
  volunteer.save
  erb(:volunteer_info)
end

delete('/delete_volunteer') do
  @volunteer = Volunteer.find(params[:id])
  @volunteer.delete()
  @volunteers = Volunteer.all()
  volunteer.save
  erb(:volunteer_info)
end
