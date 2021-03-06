require 'spec_helper'

require 'tasks_repository'

describe TasksRepository do
  let(:db) { Sequel.connect('postgres://gschool_user:password@localhost:5432/tasks_test') }

  before do
    db.create_table :tasks do
      primary_key :id
      String :name
    end
  end

  after do
    db.drop_table :tasks
  end

  it 'allows for creating of a task' do
    repo = TasksRepository.new(db)
    repo.create({:name => "Do some stuff"})
    repo.create({:name => "Do some other stuff"})
    expected_tasks = [
        {:id => 1, :name => "Do some stuff"},
        {:id => 2, :name => "Do some other stuff"}
    ]
    expect(repo.all).to eq expected_tasks
  end
end