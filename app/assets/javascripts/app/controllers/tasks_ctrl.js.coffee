App.controller 'TasksCtrl', ['$scope', 'Task', 'TaskItem', 'Faye', ($scope, $task, $task_item, $faye) ->
  $scope.message = "Angular Rocks!"
  $scope.tasks = $task.query()
  $scope.selectedTask = null
  $scope.onlineUsers = []
  $scope.clientId = () ->
    $faye.clientId()

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
    $scope.task.items = $task_item.query(task_id: $scope.task.id)

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

  ###################
  ###################
  #task items
  $scope.resetItemForm = ->
    $scope.item = null

  $scope.itemSubmit = ->
    $scope.itemCreate()
    $scope.resetItemForm()

  $scope.itemCreate = ->
    $task_item.save(
      {
        task_id: $scope.task.id
      },
      task_item:
        name: $scope.item.name
      ,
      (response) -> #success
        console.log(response)
      ,
      (response) -> #fail
        console.log(response)
    )

  $scope.itemDestroy = (item)->
    item.$delete()

  $faye.on '/task_items/new', (task_item) ->
    return unless $scope.task.id
    return unless $scope.task.id == task_item.task_item.task_id
    $scope.task.items.push new $task_item task_item.task_item

  $faye.on '/task_items/destroy', (task_item) ->
    for i in $scope.task.items
      if i.id == task_item.task_item.id
        $scope.task.items.splice(_i,1);

  ######################
  ######users###########
  ######################
  $faye.on '/users/list', (list) ->
    $scope.onlineUsers = JSON.parse list
]