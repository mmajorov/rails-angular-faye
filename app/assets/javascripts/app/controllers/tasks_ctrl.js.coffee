App.controller 'TasksCtrl', ['$scope', 'Task', 'Faye', ($scope, $task, $faye) ->
  $scope.message = "Angular Rocks!"
  $scope.tasks = $task.query()

  $scope.create = ->
  	$task.save(
  		{},
  		task:
  			name: $scope.task.name
  			done: $scope.task.done
  		,
  		(response)->
  			$scope.tasks.push response
  			console.log(response)
  		,
  		(response)->
  			console.log(response)
  	)

  $faye.on '/tasks/new', (data) ->
    console.log('in faye')
    console.log(data)
]