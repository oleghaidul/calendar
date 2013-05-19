class Calendar.Models.CalendarColor extends Backbone.Model
  paramRoot: 'calendar_color'

  defaults:
    color_name: null
    color_hash: null

  secureAttributes: [
    'created_at', 'updated_at', 'user_calendar_id'
  ]

  toJSON: ->
    @_cloneAttributes();

  _cloneAttributes: ->
    attributes = _.clone(@attributes)
    for sa in @secureAttributes
      delete attributes[sa]
    _.clone(attributes)

class Calendar.Collections.CalendarColorsCollection extends Backbone.Collection
  model: Calendar.Models.CalendarColor
  url: 'calendar_colors'

