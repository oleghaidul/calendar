Calendar.Views.CalendarColors ||= {}

class Calendar.Views.CalendarColors.NewView extends Backbone.View
  template: JST["backbone/templates/calendar_colors/new"]

  events:
    "submit #new-calendar_color": "save"

  constructor: (options) ->
    super(options)
    @model = new @collection.model()

    @model.bind("change:errors", () =>
      this.render()
    )

  save: (e) ->
    e.preventDefault()
    e.stopPropagation()

    @model.unset("errors")

    @collection.create(@model.toJSON(),
      success: (calendar_color) =>
        @model = calendar_color
        window.location.hash = "/#{@model.id}"

      error: (calendar_color, jqXHR) =>
        @model.set({errors: $.parseJSON(jqXHR.responseText)})
    )

  render: ->
    $(@el).html(@template(@model.toJSON() ))

    this.$("form").backboneLink(@model)

    return this
