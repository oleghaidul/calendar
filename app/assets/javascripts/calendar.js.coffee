$ ->
  $('.day').popover(
    html: true
    offset: 5
    title: "form"
    trigger: "manual"
  ).click ->
    $('.popover').remove()
    $(this).popover "show"
    position = $(this).position()
    $('.popover').css("top", position.top - 100)
    $.ajax(
      url: "/periods/new"
      cache: false
      ).done ->
        $('[class~=datepicker]').datepicker()
        $('.close_form').click ->
          $('.popover').hide()
