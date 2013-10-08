App.controller 'RubricsCtrl', ['$scope', 'Rubric', 'Faye', ($scope, $rubric, $faye) ->
  $scope.all_rubrics = {}
  $scope.rubrics = $rubric.query ()->
    for rubric in $scope.rubrics
      $scope.all_rubrics[rubric.id] = rubric

  $scope.clientId = () ->
    $faye.clientId()



  $scope.loadChildren = (rubric) ->
    rubric.nodes = $rubric.children id: rubric.id, (rr)->
      for r in rr
        $scope.all_rubrics[r.id] = r


  $faye.on '/rubrics/new', (task) ->
    $scope.tasks.push new $task task.task

  $faye.on '/rubrics/update', (rubric) ->
    console.log(rubric)
    if $scope.all_rubrics[rubric.rubric.id]
      $scope.all_rubrics[rubric.rubric.id].name = rubric.rubric.name
    console.log $scope.all_rubrics

  $faye.on '/rubrics/destroy', (task) ->
    console.log(task)
    for i in $scope.tasks
      if i.id == task.task.id
        $scope.tasks.splice(_i,1);
]