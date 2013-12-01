class Daltoniam.Models.Post extends Backbone.Model
  urlRoot: '/1/posts'

  parse: (response) ->
    if response.response
      response = response.response
    response.text = markdown.toHTML(response.text)
    createdAt = response.created_at
    date = new Date(createdAt) 
    dateString = date.format('mmm dd yyyy') 
    response.time = dateString
    response