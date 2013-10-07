App.directive 'resourceLocker', () ->
  lock = (form) ->
    form.find('input, textarea, button').attr 'disabled', 'disabled'

  release = (form) ->
    form.find('input, textarea, button').removeAttr 'disabled'

  scope: {}
  template: '<span ng-repeat="user in users"
                   class="label"
                   ng-class="{\'label-success\': user == clientId(), \'label-default\': user != clientId()}">{{user}}</span>'
  controller: ['$scope', '$attrs', 'Faye', ($scope, $attrs, $faye) ->
      $scope.faye = $faye
      $scope.formLocked = false
      $scope.users = []
      $scope.clientId = () ->
        $faye.clientId()

      $faye.on '/resource/lock/task/'+$attrs.resourceId, (data) ->
        console.log 'lock data', data
        data = JSON.parse data
        $scope.users = data.users
        $scope.formLocked = data.owner != $faye.clientId()
    ]
  link: ($scope, element, attrs) ->
    form = element.closest 'form'
    $scope.$watch 'formLocked', (isLocked) ->
      if isLocked
        lock form
      else
        release form





