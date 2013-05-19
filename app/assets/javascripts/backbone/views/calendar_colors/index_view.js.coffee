Calendar.Views.CalendarColors ||= {}

class Calendar.Views.CalendarColors.IndexView extends Backbone.View
  template: JST["backbone/templates/calendar_colors/index"]

  initialize: () ->
    @options.calendar_colors.bind('reset', @addAll)

  addAll: () =>
    @options.calendar_colors.each(@addOne)

  addOne: (calendarColor) =>
    view = new Calendar.Views.CalendarColors.CalendarColorView({model : calendarColor})
    @$("tbody").append(view.render().el)

  render: =>
    $(@el).html(@template(calendar_colors: @options.calendar_colors.toJSON() ))
    @addAll()

    return this
