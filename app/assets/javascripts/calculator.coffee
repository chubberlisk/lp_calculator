# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$ ->
  $("button[data-lp-minus]").click (e) ->
    currentLp = $("p#player-one-lp").html()
    currentLp -= $(this).data("lp-minus")
    if currentLp >= 0 then $("p#player-one-lp").html(currentLp)
