require'pg'
require'pry'


DB = PG.connect({:dbname => 'volunteer_tracker'})

class Volunteer
  attr_accessor(:name, :project_id)
  attr_reader(:id)

  def initialize(attributes)
    @name = attributes.fetch(:name)
    @project_id = attributes.fetch(:project_id)
    @id = attributes.fetch(:id).to_i rescue nil
  end

  def self.all
    returned_projects = DB.exec("SELECT * FROM volunteers_tb;")
    volunteers = []
    returned_volunteers.each() do |project|
      name = volunteer.fetch("name")
      volunteer_id = doctor.fetch("volunteer_id").to_i
      id = volunteer.fetch("id").to_i()
      volunteers.push(Volunteer.new({:name => name, :volunteer_id => volunteer_id, :id => id}))
    end
    volunteers
  end

  def self.find(id)
    returned_volunteers = DB.exec("SELECT * FROM volunteers_tb WHERE id = #{id};")
    returned_volunteers.each() do |volunteer|
      name = volunteer.fetch("name")
      volunteer_id = doctor.fetch("volunteer_id").to_i
      id = volunteer.fetch("id").to_i()
      return Volunteer.new({:name => name, :volunteer_id => volunteer_id, :id => id})
    end
  end

  def save
    result = DB.exec("INSERT INTO volunteers_tb(name, volunteer_id) VALUES ('#{@name}', #{volunteer_id}) RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def ==(another_volunteer)
    self.name().==(another_volunteer.name()).&(self.volunteer_id().==(another_volunteer.volunteer_id()))
  end

  def delete(id)
    DB.exec("DELETE FROM volunteers_tb WHERE id = #{volunteer.id};")
  end
end
