App.factory 'Task', ['$resource', ($resource) ->
	$resource '/tasks/:id',
    id: "@id"
  ,
    update:
      method: "PUT"
]