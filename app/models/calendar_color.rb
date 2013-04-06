class CalendarColor < ActiveRecord::Base
  belongs_to :user_calendar
  attr_accessible :color_name, :color_hash

  validates :color_name, presence: true
  def name
    color_name
  end
end
