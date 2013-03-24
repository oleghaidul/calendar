class Period < ActiveRecord::Base
  attr_accessible :calendar_id, :end_date, :info, :note, :period_type, :start_date
end
