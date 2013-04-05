class CalendarColor < ActiveRecord::Base
  belongs_to :user_calendar
  attr_accessible :color_name, :color_hash

  def name
    color_name
  end
end
