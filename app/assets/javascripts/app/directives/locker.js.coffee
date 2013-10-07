App.directive 'resourceLocker', () ->
  lock = (form) ->
    form.find('input, textarea, button').attr 'disabled', 'disabled'

  release = (form) ->
    form.find('input, textarea, button').removeAttr 'disabled'

  scope: {}
  template: '<span ng-repeat="user in users"
                   class="label"
                   ng-class="{\'label-success\': user == clientId(), \'label-default\': user != clientId()}">{{user}}</span>'
  controller: ['$scope', 'Faye', ($scope, $faye) ->
      $scope.faye = $faye
      $scope.formLocked = false
      $scope.users = []
      $scope.clientId = () ->
        $faye.clientId()

      $faye.on '/resource/lock/**', (data) ->
        console.log 'ALL locks', data


      $faye.on '/resource/lock/task/5', (data) ->
        console.log 'lock data', data
        data = JSON.parse data
        $scope.users = data.users
        $scope.formLocked = data.owner != $faye.clientId()
    ]
  link: ($scope, element, attrs) ->
    $scope.tid = attrs.resourceId
    console.log $scope.tid

    form = element.closest 'form'
    $scope.$watch 'formLocked', (isLocked) ->
      if isLocked
        lock form
      else
        release form





