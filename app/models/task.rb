require 'eventmachine'

class Task < ActiveRecord::Base
	validates :name, presence: true
  after_create :notify_create

  def notify_create
    Bayeux.client.publish('/tasks/new', task: self.attributes)
  end
end
