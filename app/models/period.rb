class Period < ActiveRecord::Base
  attr_accessible :user_calendar_id, :end_date, :info, :note, :period_type, :start_date, :color, :color_name
  belongs_to :user_calendar

  validates :start_date, :end_date, presence: true
  validate :check_intersection

  private

    def check_intersection
      overlap = user_calendar.periods.where { (end_date > my{start_date}) & (start_date < my{start_date}) }
      errors.add(:base, "Date range overlaps with these events: #{overlap.map { |o| o.start_date..o.end_date }.join(', ')}") if overlap.size > 0
    end
end
