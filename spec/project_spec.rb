require "spec_helper"

describe Project do
  describe '#title' do
    it 'returns the project title' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      expect(project.title).to eq 'Teaching Kids to Code'
    end
  end

  context '#id' do
    it 'returns the id of the project before saving project' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      expect(project.id).to eq nil
    end

    it 'returns the id of the project after saving project' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project.save
      expect(project.id).to be_an_instance_of Integer
    end
  end

  describe '#==' do
    it 'is the same project if two projects have the same title' do
      project1 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project2 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      expect(project1 == project2).to eq true
    end
  end

  context '.all' do
    it 'is empty to start' do
      expect(Project.all).to eq []
    end

    it 'returns all projects' do
      project1 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project1.save
      project2 = Project.new({:title => 'Teaching Ruby to Kids', :id => nil})
      project2.save
      expect(Project.all).to eq [project1, project2]
    end
  end

  describe '#save' do
    it 'saves a project to the database' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project.save
      expect(Project.all).to eq [project]
    end
  end

  describe '.find' do
    it 'returns a project by id' do
      project1 = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project1.save
      project2 = Project.new({:title => 'Teaching Ruby to Kids', :id => nil})
      project2.save
      expect(Project.find(project1.id)).to eq project1
    end
  end

  describe '#volunteers' do
    it 'returns all volunteers for a specific project' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project.save
      volunteer1 = Volunteer.new({:name => 'Jasmine', :project_id => project.id, :id => nil})
      volunteer1.save
      volunteer2 = Volunteer.new({:name => 'Joe', :project_id => project.id, :id => nil})
      volunteer2.save
      expect(project.volunteers).to eq [volunteer1, volunteer2]
    end
  end

  describe '#update' do
    it 'allows a user to update a project' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project.save
      project.update({:title => 'Teaching Ruby to Kids', :id => nil})
      expect(project.title).to eq 'Teaching Ruby to Kids'
    end
  end

  context '#delete' do
    it 'allows a user to delete a project' do
      project = Project.new({:title => 'Teaching Kids to Code', :id => nil})
      project.save
      project.delete
      expect(Project.all).to eq []
    end
  end
end
