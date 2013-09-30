App.controller 'TasksCtrl', ['$scope', 'Task', ($scope, $task) ->
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
]