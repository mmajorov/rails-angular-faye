App.factory 'Rubric', ['$resource', ($resource) ->
	$resource '/rubrics/:id/:verb',
    id: "@id"
    verb: "@verb"
  ,
    update:
      method: "PUT"

    children:
      method: "GET"
      isArray: true
      params:
        verb: 'children'
]