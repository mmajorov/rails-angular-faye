json.array!(@task_items) do |task_item|
  json.extract! task_item, :id, :name, :task_id
  json.url task_item_path(task_item.task, task_item, format: :json)
  json.tasks []
end
