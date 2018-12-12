class Project
  attr_accessor(:title)
  attr_reader(:id)

  def initialize(attributes)
    @title = attributes.fetch(:title)
    @id = attributes.fetch(:id, nil)
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

  def self.sort
    returned_projects = DB.exec("SELECT * FROM projects_tb ORDER BY title;")
    projects = []
    returned_projects.each() do |project|
      title = author.fetch("title")
      id = author.fetch("id").to_i()
      projects.push(Author.new({:name => name, :id => id}))
    end
    projects
  end

  def update(attributes)
    @title = attributes.fetch(:title)
    @id = self.id()
    DB.exec("UPDATE projects_tb SET title = '#{@title}' WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO projects_tb(title) VALUES ('#{@title}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_project)
    self.title().==(another_project.title())
  end

  def delete()
    DB.exec("DELETE FROM projects_tb WHERE id = #{self.id};")
  end

  def volunteers
    volunteers = DB.exec("SELECT * FROM volunteers_tb WHERE project_id = #{self.id};")
    project_volunteers = []
    volunteers.each() do |results|
      name = results.fetch("name")
      project_id = results.fetch("project_id").to_i
      id = results.fetch("id").to_i
      project_volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => nil}))
    end
    project_volunteers
  end
end
