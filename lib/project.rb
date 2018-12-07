require'pg'
require'pry'


DB = PG.connect({:dbname => 'volunteer_tracker'})

class Project
  attr_accessor(:title)
  attr_reader(:id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id).to_i rescue nil
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects_tb;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:title => title, :id => id}))
    end
    projects
  end

  def self.find(id)
    returned_projects = DB.exec("SELECT * FROM projects_tb WHERE id = #{id};")
    returned_projects.each() do |project|
      title = project.fetch("title")
      id = project.fetch("id").to_i()
      return Project.new({:title => title, :id => id})
    end
  end

  def save
    result = DB.exec("INSERT INTO projects_tb(title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def delete(id)
    DB.exec("DELETE FROM projects_tb WHERE id = #{project.id};")
  end
end
