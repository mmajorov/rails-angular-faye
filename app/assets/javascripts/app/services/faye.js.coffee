App.factory 'Faye', ($rootScope) ->
  faye = new Faye.Client('http://localhost:9292/faye')

  on: (channel, callback) ->
    faye.subscribe channel, (data) ->
      callback data

  emit: (channel, data, callback) ->
    faye.publish channel, data
    if callback
      callback arguments