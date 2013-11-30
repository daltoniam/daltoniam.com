class Daltoniam.Views.PostView extends Backbone.View
  template: HoganTemplates['post']

  events: 
    "click .dateCircle" : "goPost"
    "click .anchorText" : "goPost"

  render: ->
    @$el.html @template.render(@model.attributes)

  goPost: ->
    id = $(".postContent").attr("id")
    console.log("got an id: #{id}")
    $(".blogContent").addClass('animated bounceOutLeft')
    inceptionRouter.navigate("blog/#{id}", trigger: true)