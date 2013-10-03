class TaskItem < ActiveRecord::Base
  validates :name, :task_id, presence: true

  belongs_to :task

  after_create :notify_create
  after_update :notify_update
  after_destroy :notify_destroy

  def notify_create
    Bayeux.client.publish('/task_items/new', task_item: self.attributes)
  end

  def notify_update
    Bayeux.client.publish('/task_items/update', task_item: self.attributes)
  end

  def notify_destroy
    Bayeux.client.publish('/task_items/destroy', task_item: self.attributes)
  end
end
