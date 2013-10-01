window.App = angular.module('AngularTasks', ['ngResource'])
#client.subscribe '/tasks', (payload)->
#  console.log payload