require 'eventmachine'

class Task < ActiveRecord::Base
	validates :name, presence: true
  after_create :notify_faye

  def notify_faye
    Bayeux.client.publish('/tasks/new', 'text' => 'Task created')
  end
end
