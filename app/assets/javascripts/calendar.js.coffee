$ ->
  calendar_id = $('.ability').data('calendar-id')

  if $('.ability').data('editable')
    $('.day').click ->
      data = $(this).data("date")
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
      if !$(@).hasClass('hover')
        $.ajax(
          url: "/periods/new?calendar_id=#{calendar_id}"
          cache: false
          ).done ->
            $('#period_start_date').val(data)
            $('[class~=datepicker]').datepicker
              "autoclose": true
              format: 'yyyy-mm-dd'
              startDate: data
            $('input.cp1').colorpicker()
            $('.close_form').click ->
              $('.colorpicker.dropdown-menu').remove()
              $('.popover').remove()
            $('#show_more').click ->
              if $('.show_more_fields').css("display") == "none"
                $('.show_more_fields').show('slow')
                $('#show_more').html("show less")
              else
                $('.show_more_fields').hide('slow')
                $('#show_more').html("show more")
      else
        period_id = $(@).data('period-id')
        $.ajax(
          url: "/periods/#{period_id}/edit?calendar_id=#{calendar_id}"
          cache: false
          ).done ->
            $('[class~=datepicker]').datepicker
              "autoclose": true
              format: 'yyyy-mm-dd'
              startDate: data
            $('input.cp1').colorpicker()
            $('.close_form').click ->
              $('.colorpicker.dropdown-menu').remove()
              $('.popover').remove()
            $('#show_more').click ->
              if $('.show_more_fields').css("display") == "none"
                $('.show_more_fields').show('slow')
                $('#show_more').html("show less")
              else
                $('.show_more_fields').hide('slow')
                $('#show_more').html("show more")

  get_popover_placement = (pop, dom_el) ->
    width = window.innerWidth
    width = width / 2
    left_pos = $(dom_el).offset().left
    return "left"  if width < left_pos
    "right"

  $('.day').each ->
    status = $(this).data("status")
    if status == "bouth"
      color = $(this).data("color")
      start_color = color[0]
      end_color = color[1]
      $(this).css("background", "-webkit-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      $(this).css("background", "-webkit-gradient(linear, left top, right bottom, color-stop(47%,"+end_color+"), color-stop(48%,#000000), color-stop(52%,000000), color-stop(47%,"+start_color+"))")
      $(this).css("background", "-moz-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      $(this).css("background", "-o-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      $(this).css("background", "-ms-linear-gradient(-45deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      $(this).css("background", "linear-gradient(135deg, "+end_color+" 47%, #000000 48%, #000000 52% ,"+start_color+" 47%)")
      $(this).css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='"+end_color+"', endColorstr='"+start_color+"',GradientType=1)")
    else if status == "start"
        color = $(this).data("color")
        $(this).css("background", "-webkit-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        $(this).css("background", "-webkit-gradient(linear, right bottom, left top, color-stop(50%,"+color+"), color-stop(50%,#ffffff))")
        $(this).css("background", "-moz-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        $(this).css("background", "-o-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        $(this).css("background", "-ms-linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
        $(this).css("background", "linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
        $(this).css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='#ffffff', endColorstr='"+color+"',GradientType=1)")
      else if status == "end"
          color = $(this).data("color")
          $(this).css("background", "-webkit-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          $(this).css("background", "-webkit-gradient(linear, left top, right bottom, color-stop(50%,"+color+"), color-stop(50%,#ffffff))")
          $(this).css("background", "-moz-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          $(this).css("background", "-o-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          $(this).css("background", "-ms-linear-gradient(-45deg, "+color+" 50%, #ffffff 50%)")
          $(this).css("background", "linear-gradient(135deg, "+color+" 50%, #ffffff 50%)")
          $(this).css("filter", "progid:DXImageTransform.Microsoft.gradient( startColorstr='"+color+"', endColorstr='#ffffff',GradientType=1)")
        else if status == "between"
            color = $(this).data("color")
            $(this).css("background", color)

  $(".day").hover ->
    period_id = $(@).data('period-id')[0] || $(@).data('period-id')
    $(".day[data-period-id^='[#{period_id}']").toggleClass('hover')
    $(".day[data-period-id=#{period_id}][data-status=start]").toggleClass('hover all')
    $(".day[data-period-id=#{period_id}][data-status=between]").toggleClass('hover all')