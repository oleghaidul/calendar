class Period < ActiveRecord::Base
  attr_accessible :calendar_id, :end_date, :info, :note, :period_type, :start_date, :color
  belongs_to :calendar
end
