window.App = angular.module('AngularTasks', ['ngResource'])
$ ->
  faye = new Faye.Client('http://localhost:9292/faye')
  faye.subscribe '/tasks/new', (data) ->
    console.log(data)
#client.subscribe '/tasks', (payload)->
#  console.log payload