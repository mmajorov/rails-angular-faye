App.controller 'RubricsCtrl', ['$scope', 'Rubric', 'Faye', ($scope, $rubric, $faye) ->
  $scope.rubrics = $rubric.query()
  $scope.clientId = () ->
    $faye.clientId()

  $scope.loadChildren = (rubric) ->
    rubric.nodes = $rubric.children(id: rubric.id)
    console.log rubric

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