#= require jquery
#= require jquery_ujs
#= require hogan
#= require lib/underscore-min
#= require lib/backbone-min
#= require daltoniam
#= require bootstrap
#= require_tree .
#= require lib/date

$(document).ready ->
  window.inceptionRouter = new Daltoniam.Routers.InceptionRouter()
  Backbone.history.start
    pushState: true
    hashChange: false