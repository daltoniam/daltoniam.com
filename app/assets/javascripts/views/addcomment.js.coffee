class Daltoniam.Views.AddCommentView extends Backbone.View
  template: HoganTemplates['addcomment']

  events: 
    'submit #commentForm' : 'addComment'

  render: ->
    @$el.html @template.render()
    #$('.editable').mediumImages(uploadScript: '/1/upload') not images for comments, that would end badly

  addComment: (e) ->
    e.preventDefault()
    markdown = html2markdown(@$('.editable').html())
    $.post("/1/posts/#{@model.attributes.id}/comments", text: markdown)
      .done((data) =>
        console.log "add comment to UI"
      )
      .fail((data) =>
        console.log "failure message here"
      )
