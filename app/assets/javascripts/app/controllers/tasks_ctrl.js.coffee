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
  			email: $scope.task.email
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
    $scope.resetForm()
    $scope.selectedTask = task
    $scope.task = angular.copy task

  $scope.update = ->
    $scope.task.$update()
    $scope.resetForm()

  $scope.destroy = ->
    $scope.selectedTask.$delete()
    $scope.resetForm()

  $faye.on '/tasks/new', (task) ->
    $scope.tasks.push new $task task.task

  $faye.on '/tasks/update', (task) ->
    console.log(task)
    $scope.tasks.forEach (t) ->
      if t.id == task.task.id
        t.name = task.task.name
        t.email = task.task.email
        t.done = task.task.done

  $faye.on '/tasks/destroy', (task) ->
    console.log(task)
    for i in $scope.tasks
      if i.id == task.task.id
        $scope.tasks.splice(_i,1);
]