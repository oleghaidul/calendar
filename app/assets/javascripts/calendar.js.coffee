$ ->
  calendar_id = $('.ability').data('calendar-id')

  if $('.ability').data('editable')
    $('.day').click ->
      data = $(this).attr("params").split("-")
      $('.day').popover(
        html: true
        placement: get_popover_placement
        title: "<h4>Create new period</h4>"
        trigger: "manual"
      )
      $('.popover').remove()
      $(this).popover "show"
      position = $(this).position()
      calendar_height = $('.calendar-wrapper').css("height")
      calendar_height = parseInt(calendar_height)
      pop_top = $('.popover').position().top
      crit_top = calendar_height - 100
      if pop_top < crit_top
        $('.popover').css("top", position.top - 150)
      else
        $('.popover').css("top", crit_top)
      pop_pos = $('.popover').position()
      temp = position.top - pop_pos.top
      proc = temp * 100 / 522
      y_coord = proc / 100 * 522 + 8
      $('.arrow').css("top", y_coord)
      $.ajax(
        url: "/periods/new?calendar_id=#{calendar_id}"
        cache: false
        ).done ->
          $('#period_start_date').val(data[1] + "/" + data[2] + "/" + data[0])
          $('[class~=datepicker]').datepicker
            "autoclose": true
          $('.close_form').click ->
            $('.popover').remove()
          $('#show_more').click ->
            if $('.show_more_fields').css("display") == "none"
              $('.show_more_fields').show('fast')
              $('#show_more').html("show less")
            else
              $('.show_more_fields').hide('fast')
              $('#show_more').html("show more")

  get_popover_placement = (pop, dom_el) ->
    width = window.innerWidth
    width = width / 2
    left_pos = $(dom_el).offset().left
    return "left"  if width < left_pos
    "right"
