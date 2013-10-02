App.controller 'TasksCtrl', ['$scope', 'Task', 'Faye', ($scope, $task, $faye) ->
  $scope.message = "Angular Rocks!"
  $scope.tasks = $task.query()
  $scope.selectedTask = null

  $scope.resetForm = ->
    $scope.selectedTask = null
    $scope.task = null

  $scope.submit = ->
    if $scope.selectedTask
      $scope.update()
    else
      $scope.create()

  $scope.create = ->
  	$task.save(
  		{},
  		task:
  			name: $scope.task.name
  			done: $scope.task.done
  		,
  		(response)-> #success
        console.log(response)
        $scope.resetForm()
  		,
  		(response)-> #fail
  			console.log(response)
  	)

  $scope.edit = (task)->
    $scope.selectedTask = task
    $scope.task = angular.copy task

  $scope.update = ->
    $scope.task.$update()
    $scope.resetForm()

  $faye.on '/tasks/new', (task) ->
    $scope.tasks.push new $task task.task

  $faye.on '/tasks/update', (task) ->
    console.log(task)
    $scope.tasks.forEach (t) ->
      if t.id == task.task.id
        t.name = task.task.name
        t.done = task.task.done
]