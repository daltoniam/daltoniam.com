class Daltoniam.Views.AddCommentView extends Backbone.View
  template: HoganTemplates['addcomment']

  #events: 
  #  'submit #commentForm' : 'addComment'

  render: ->
    @$el.html @template.render()
    #$('.editable').mediumImages(uploadScript: '/1/upload') not images for comments, that would end badly
