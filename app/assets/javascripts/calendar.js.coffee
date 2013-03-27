$ ->
  $('.day').popover(
    html: true
    title: "form"
    trigger: "manual"
  ).click ->
    $('.popover').remove()
    $(this).popover "show"
    position = $(this).position()
    $('.popover').css("top", position.top - 100)
    correct = $(this).offset()
    if correct.top > 248
      $('.popover').css('top', 300 - correct.top)
    if correct.top > 610
      $('.popover').css('top', -315)
    pop_pos = $('.popover').position()
    temp = position.top - pop_pos.top
    proc = temp * 100 / 522
    y_coord = proc / 100 * 522 + 8
    $('.arrow').css("top", y_coord)
    $.ajax(
      url: "/periods/new"
      cache: false
      ).done ->
        $('[class~=datepicker]').datepicker()
        $('.close_form').click ->
          $('.popover').hide()