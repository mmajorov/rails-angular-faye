class Rubric < ActiveRecord::Base
  acts_as_nested_set

  after_create :notify_create
  after_update :notify_update
  after_destroy :notify_destroy

  def notify_create
    Bayeux.client.publish('/rubrics/new', rubric: self.attributes)
  end

  def notify_update
    Bayeux.client.publish('/rubrics/update', rubric: self.attributes)
  end

  def notify_destroy
    Bayeux.client.publish('/rubrics/destroy', rubric: self.attributes)
  end
end
