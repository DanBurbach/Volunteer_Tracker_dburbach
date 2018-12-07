require'pg'
require'pry'


DB = PG.connect({:dbname => 'volunteer_tracker'})

class Volunteer
  attr_accessor(:name, :project_id)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id).to_i
    @id = attributes.fetch(:id).to_i rescue nil
  end

  def self.all
    returned_volunteers = DB.exec("SELECT * FROM volunteers_tb;")
    volunteers = []
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id")
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:name => name, :project_id => project_id, :id => id}))
    end
    volunteers
  end

  def self.id
    returned_volunteers = DB.exec("SELECT * FROM volunteers_tb WHERE id = #{project_id};")
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id")
      id = volunteer.fetch("id").to_i()
      return Volunteer.new({:name => name, :project_id => project_id, :id => id})
    end
  end

  def self.find(id)
    returned_volunteers = DB.exec("SELECT * FROM volunteers_tb WHERE id = #{id};")
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      project_id = volunteer.fetch("project_id")
      id = volunteer.fetch("id").to_i()
      return Volunteer.new({:name => name, :project_id => project_id, :id => id})
    end
  end

  def update(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id).to_i
    @id = self.id()
    DB.exec("UPDATE patron SET name = '#{@name}' WHERE id = #{@id};")
  end

  def save
    result = DB.exec("INSERT INTO volunteers_tb(name, project_id) VALUES ('#{@name}', '#{@project_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_volunteer)
    (self.name().==(another_volunteer.name())).&(self.project_id().==(another_volunteer.project_id()))
  end

  def delete(id)
    DB.exec("DELETE FROM volunteers_tb WHERE id = #{self.id};")
  end
end
