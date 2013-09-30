App.factory 'Task', ['$resource', ($resource) ->
	$resource '/tasks/:id', id: '@id'
]