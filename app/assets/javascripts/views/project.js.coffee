class Daltoniam.Views.ProjectView extends Backbone.View
  template: HoganTemplates['project']
  el: "#app"

  events: 
    "click .projectMain" : "goHome"

  render: ->
    @$el.html @template.render()

  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.projectCircle').css("background": "#2c3e50")
    $('.projects').removeClass('bounceInUp').addClass('bounceOutDown')
    $('.postHeader').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.postMain').addClass('animated bounceOutDown')
    height = $('.projectMain').height()
    height = height*2 - 20
    pixelStr = "#{height}"
    $('.projectMain').transition(y: pixelStr, delay: 600, complete: -> inceptionRouter.navigate("home/project", trigger: true))