class Daltoniam.Views.AboutView extends Backbone.View
  template: HoganTemplates['about']
  el: "#app"

  events: 
    "click .aboutMain" : "goHome"

  render: ->
    @$el.html @template.render()

  goHome: ->
    $('.backArrow').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.aboutCircle').css("background": "#16a085")
    $('.postHeader').removeClass('fadeInRight').addClass('fadeOutRight')
    $('.postMain').addClass('animated bounceOutDown')
    height = $('.aboutMain').height() - 20
    pixelStr = "#{height}"
    $('.aboutMain').transition(y: pixelStr, delay: 600, complete: -> inceptionRouter.navigate("home/about", trigger: true))