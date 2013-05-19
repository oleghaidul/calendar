class Calendar.Routers.CalendarColorsRouter extends Backbone.Router
  initialize: (options) ->
    @calendar_colors = new Calendar.Collections.CalendarColorsCollection()
    @calendar_colors.reset options.calendar_colors

  routes:
    "new"      : "newCalendarColor"
    "index"    : "index"
    ":id/edit" : "edit"
    ".*"        : "index"

  newCalendarColor: ->
    @view = new Calendar.Views.CalendarColors.NewView(collection: @calendar_colors)
    $("#calendar_colors").html(@view.render().el)

  index: ->
    @view = new Calendar.Views.CalendarColors.IndexView(calendar_colors: @calendar_colors)
    $("#calendar_colors").html(@view.render().el)

  show: (id) ->
    calendar_color = @calendar_colors.get(id)

    @view = new Calendar.Views.CalendarColors.ShowView(model: calendar_color)
    $("#calendar_colors").html(@view.render().el)

  edit: (id) ->
    calendar_color = @calendar_colors.get(id)

    @view = new Calendar.Views.CalendarColors.EditView(model: calendar_color)
    $("#calendar_colors").html(@view.render().el)
