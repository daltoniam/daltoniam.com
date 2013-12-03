class Daltoniam.Views.CommentView extends Backbone.View
  template: HoganTemplates['comment']

  initialize: (attribs) ->
    if attribs.text
      attribs.text = markdown.toHTML(attribs.text)
    @attributes = attribs
  render: ->
    @$el.html @template.render(@attributes)
