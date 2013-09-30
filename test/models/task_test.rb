require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  setup do
  	@task_defaults = {
  		name: 'Test task',
  		done: false
  	}
  end

  test "invalid if missing required data" do
  	task = Task.new
  	assert !task.valid?
  	[:name, :done].each do |field_name|
  		assert task.errors.keys.include? field_name
  	end
  end

  test "valid if required data exists" do 
  	task = Task.new @task_defaults
  	assert task.valid?
  end
end
