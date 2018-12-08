require'pg'
require'pry'


DB = PG.connect({:dbname => 'volunteer_tracker'})

class Project
  attr_accessor(:title, :detail)
  attr_reader(:id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @detail = attributes.fetch(:detail)
    @id = attributes.fetch(:id).to_i rescue nil
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM projects_tb;")
    projects = []
    returned_projects.each() do |project|
      title = project.fetch("title")
      detail = project.fetch("detail")
      id = project.fetch("id").to_i()
      projects.push(Project.new({:title => title, :detail => detail, :id => id}))
    end
    projects
  end

  def self.find(id)
    returned_projects = DB.exec("SELECT * FROM projects_tb WHERE id = #{id};")
    returned_projects.each() do |project|
      title = project.fetch("title")
      detail = project.fetch("detail")
      id = project.fetch("id").to_i()
      return Project.new({:title => title, :detail => detail, :id => id})
    end
  end

  def self.sort
    returned_projects = DB.exec("SELECT * FROM projects_tb ORDER BY title;")
    projects = []
    returned_projects.each() do |project|
      title = author.fetch("title")
      detail = project.fetch("detail")
      id = author.fetch("id").to_i()
      projects.push(Author.new({:title => title, :detail => detail, :id => id}))
    end
    projects
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    @detail = attributes.fetch(:detail)
    @id = self.id()
    DB.exec("UPDATE projects_tb SET title = '#{@title}','#{@detail}' WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO projects_tb(title, detail) VALUES ('#{@title}','#{@detail}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title()).&(self.detail().==(another_project.detail()))
  end

  def delete()
    @id = self.id()
    DB.exec("DELETE FROM projects_tb WHERE id = #{self.id()};")
  end

  # def volunteers
  #   volunteers = DB.exec("SELECT * FROM volunteers_tb WHERE id = #{project_id};")
  #   project_volunteers = []
  #   volunteers.each() do |results|
  #     name = results.fetch("name")
  #     project_id = results.fetch("project_id").to_i
  #     id = results.fetch("id").to_i
  #     project_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id})
  #   end
  #   project_volunteers
  # end
end
