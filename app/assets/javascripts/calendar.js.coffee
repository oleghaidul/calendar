$ ->
  $("#calendar").Calendar(
    now: new Date("October 1")
    weekStart: 1
  ).on("changeDay", (event) ->
    # alert event.day.valueOf()
  ).on("onEvent", (event) ->
    # alert event.day.valueOf()
  ).on("onNext", (event) ->
    alert "Next"
  ).on("onPrev", (event) ->
    alert "Prev"
  ).on "onCurrent", (event) ->
    alert "Current"

  $('.popover-link').popover
    html: true

  $('.day').popover
    html: true
    title: "asdasd"
    content: "ddd"
