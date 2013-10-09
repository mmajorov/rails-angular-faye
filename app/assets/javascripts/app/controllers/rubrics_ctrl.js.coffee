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


  $faye.on '/rubrics/new', (rubric) ->
    res = new $rubric rubric.rubric
    res.nodes = []
    $scope.all_rubrics[res.id] = res

    if res.parent_id
      $scope.all_rubrics[res.parent_id].nodes.push res
    else
      $scope.rubrics.push res

  $faye.on '/rubrics/update', (rubric) ->
    if $scope.all_rubrics[rubric.rubric.id]
      $scope.all_rubrics[rubric.rubric.id].name = rubric.rubric.name

  $faye.on '/rubrics/destroy', (task) ->
    console.log(task)
    for i in $scope.tasks
      if i.id == task.task.id
        $scope.tasks.splice(_i,1);
]