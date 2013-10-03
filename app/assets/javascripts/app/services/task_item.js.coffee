App.factory 'TaskItem', ['$resource', ($resource) ->
	$resource '/tasks/:task_id/items/:id',
    id: "@id",
    task_id: "@task_id"
  ,
    update:
      method: "PUT"
]