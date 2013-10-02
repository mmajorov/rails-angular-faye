require 'eventmachine'

class Task < ActiveRecord::Base
	validates :name, presence: true
  after_create :notify_create
  after_update :notify_update

  def notify_create
    Bayeux.client.publish('/tasks/new', task: self.attributes)
  end

  def notify_update
    Bayeux.client.publish('/tasks/update', task: self.attributes)
  end
end
