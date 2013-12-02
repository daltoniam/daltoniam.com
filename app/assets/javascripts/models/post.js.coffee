class Daltoniam.Models.Post extends Backbone.Model
  urlRoot: '/1/posts'

  parse: (response) ->
    if response.response
      response = response.response
    if response.text
      response.text = markdown.toHTML(response.text)
    if response.preview
      response.preview = markdown.toHTML(response.preview)

    #get the comment count
    if response.comments
      response.comment_count = response.comments.length
    if response.comment_ids
      response.comment_count = response.comment_ids.length
      
    createdAt = response.created_at
    date = new Date(createdAt) 
    dateString = date.format('mmm dd yyyy') 
    response.time = dateString
    response