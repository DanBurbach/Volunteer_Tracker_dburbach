require 'sinatra'
require 'sinatra/reloader'
require 'pry'
also_reload('./lib/**/*.rb')
require './lib/project'
require './lib/volunteer'

DB = PG.connect({:dbname => 'volunteer_tracker'})

get ('/') do
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects_home)
end

# project listing data
# ----------------------------

post('/add_project') do
  title = params.fetch("title")
  project = Project.new(:title => title, :id => nil)
  project.save
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects_home)
end

get('/project/:id') do
  @project = Project.find(params[:id])
  @projects = Project.all()
  erb(:project_info)
end

get("/project_edit/:id") do
  id = params[:id].to_i
  @project = Project.find(params[:id])
  erb(:project_info)
end

patch("/update_project/:id") do
  title = params.fetch("title")
  id = params [:id].to_i
  @project = Project.find(params[:id])
  @project.update({:title => title, :id => nil})
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:project_info)
end

delete('/delete_project/:id') do
  @project = Project.find(params[:id])
  @project.delete
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects_home)
end

# volunteer listing data
# -------------------------------------------

post('/add_volunteer') do
  name = params.fetch("name")
  project_id = params.fetch("project_id")
  volunteer = Volunteer.new({:name => name, :project_id => project_id, :id => nil})
  volunteer.save
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:projects_home)
end

# display a volunteer page

get('/edit_volunteer/:id') do
  name = params.fetch("name")
  project_id = params.fetch("project_id").to_i
  id = params[:id].to_i
  @volunteer = Volunteer.find(id)
  @volunteer.update({:name => name, :project_id => project_id, :id => nil})
  @projects = Project.all
  @volunteers = Volunteers.all
  erb(:volunteer_info)
end


delete('/delete_volunteer') do
  @volunteer = Volunteer.find(params[:id])
  @volunteer.delete
  @projects = Project.all
  @volunteers = Volunteer.all
  erb(:volunteer_info)
end
