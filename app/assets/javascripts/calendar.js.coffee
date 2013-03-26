$ ->
  $('.day').popover(
    html: true
    title: "form"
    trigger: "manual"
  ).click ->
    $('.popover').hide()
    $(this).popover "show"
    $.ajax(
      url: "/periods/new"
      cache: false
      ).done ->
       $('[class~=datepicker]').datepicker()