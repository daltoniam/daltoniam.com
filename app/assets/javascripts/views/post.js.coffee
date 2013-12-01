class Daltoniam.Views.PostView extends Backbone.View
  template: HoganTemplates['post']

  events: 
    "click .dateCircle" : "goPost"
    "click .anchorText" : "goPost"

  render: ->
    @$el.html @template.render(@model.attributes)

  goPost: ->
    id = $(".postContent").attr("id")
    $(".blogContent").addClass('animated bounceOutLeft')
    $('.blogContent').one('webkitAnimationEnd mozAnimationEnd oAnimationEnd animationEnd', () -> inceptionRouter.navigate("blog/#{id}", trigger: true))