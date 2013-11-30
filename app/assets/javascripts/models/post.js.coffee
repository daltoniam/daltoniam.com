class Daltoniam.Models.Post extends Backbone.Model
  urlRoot: '/1/posts'

  parse: (response) ->
    console.log("running post parse")
    console.dir(response)
    createdAt = response.created_at
    date = new Date(createdAt) 
    dateString = date.format('mmm dd yyyy') 
    response.time = dateString
    response