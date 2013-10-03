class TaskItem < ActiveRecord::Base
  validates :name, :task_id, presence: true

  belongs_to :task
end
