class Period < ActiveRecord::Base
  attr_accessible :user_calendar_id, :end_date, :info, :note, :period_type, :start_date, :color, :color_name
  belongs_to :user_calendar

  validate :check_intersection
  validate :end_date_before_start_date
  validate :end_date_eq_start_date
  validates :start_date, presence: true, unless: proc { end_date.nil? }
  validates :end_date, presence: true, unless: proc { start_date.nil? }

  after_save :check_date_range

  private

    def check_intersection
      overlap = user_calendar.periods.where { (end_date > my{start_date}) & (start_date < my{start_date}) }
      errors.add(:base, "Date range overlaps with these events: #{overlap.map { |o| o.start_date..o.end_date }.join(', ')}") if overlap.size > 0
    end

    def end_date_before_start_date
      if end_date && start_date
        errors.add(:end_date, "can't be less than start date") if end_date < start_date
      end
    end

    def end_date_eq_start_date
      errors.add(:end_date, "can't be equal start date") if start_date && start_date == end_date
    end

    def check_date_range
      destroy if start_date.nil? && end_date.nil?
    end
end
