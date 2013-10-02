App.controller 'TasksCtrl', ['$scope', 'Task', 'Faye', ($scope, $task, $faye) ->
  $scope.message = "Angular Rocks!"
  $scope.tasks = $task.query()
  $scope.selectedTask = null

  $scope.create = ->
  	$task.save(
  		{},
  		task:
  			name: $scope.task.name
  			done: $scope.task.done
  		,
  		(response)-> #success
  			console.log(response)
  		,
  		(response)-> #fail
  			console.log(response)
  	)

  $scope.edit = (task)->
    $scope.selectedTask = task
    $scope.task = task

  $faye.on '/tasks/new', (task) ->
    $scope.tasks.push new $task task.task
]