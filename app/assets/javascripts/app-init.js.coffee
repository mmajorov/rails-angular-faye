window.App = angular.module('AngularTasks', ['ngResource'])
$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe '/messages/new', (data) ->
    alert(data)
#client.subscribe '/tasks', (payload)->
#  console.log payload