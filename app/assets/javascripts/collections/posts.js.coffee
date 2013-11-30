#= require ../models/post

class Daltoniam.Collections.Posts extends Backbone.Collection
  model: Daltoniam.Models.Post
  url: '/1/posts'

  parse: (response) ->
    @perPage = response.pagination.per_page
    @previous = response.pagination.previous
    @next = response.pagination.next
    @count = response.pagination.count
    #console.dir(response.response)
    response.response