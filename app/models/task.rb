require 'eventmachine'

class Task < ActiveRecord::Base
	validates :name, :email, presence: true

  has_many :task_items

  after_create :notify_create
  after_update :notify_update
  after_destroy :notify_destroy

  def notify_create
    Bayeux.client.publish('/tasks/new', task: self.attributes)
  end

  def notify_update
    Bayeux.client.publish('/tasks/update', task: self.attributes)
  end

  def notify_destroy
    Bayeux.client.publish('/tasks/destroy', task: self.attributes)
  end
end
