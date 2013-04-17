class Period < ActiveRecord::Base
  attr_accessible :user_calendar_id, :end_date, :info, :note, :period_type, :start_date, :color, :color_name, :first_name, :last_name, :adult_guests, :children_guests, :calendar_color_id, :email, :phone, :address1, :address2, :country, :city, :state, :post_code, :price, :start_time, :end_time
  belongs_to :user_calendar

  belongs_to :calendar_color

  # validate :check_intersection
  validate :end_date_before_start_date
  validate :end_date_eq_start_date
  validates :start_date, :end_date, :overlap => {:exclude_edges => ["start_date", "end_date"], :scope => "user_calendar_id"}
  validates :start_date, presence: true, unless: proc { end_date.nil? }
  validates :end_date, presence: true, unless: proc { start_date.nil? }
  validates :calendar_color, presence: true

  after_save :check_date_range

  def color
    calendar_color.try(:color_hash) || '#ff0000'
  end

  def color_name
    read_attribute(:color_name) || 'Default'
  end

  def start_date=(date)
    self.send(:write_attribute, :start_date, date.to_date)
  end

  def end_date=(date)
    self.send(:write_attribute, :end_date, date.to_date)
  end

  private

    def check_intersection
      if user_calendar
        overlap = user_calendar.periods.where { (end_date > my{start_date}) & (start_date < my{start_date}) }
        errors.add(:base, "Date range overlaps with these events: #{overlap.map { |o| o.start_date..o.end_date }.join(', ')}") if overlap.size > 0
      end
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

    def self.send_notification
      @periods_end = Period.where{end_date > Date.today}.where{ end_date <= Date.today+1}.includes(:user_calendar)
      @periods_end.each do |period|
        if period.user_calendar.user.email == "xx999xx@mail.ru" #test
          Notifier.send_notification( period.user_calendar.user.email,
                                      period.user_calendar.name,
                                      period,
                                      false).deliver
        end
      end
      @periods_start = Period.where{start_date > Date.today }.where{ start_date <= Date.today+1}.includes(:user_calendar)
      @periods_start.each do |period_start|
        if period_start.user_calendar.user.email == "xx999xx@mail.ru" #test
          Notifier.send_notification( period_start.user_calendar.user.email,
                                      period_start.user_calendar.name,
                                      period_start,
                                      true).deliver
        end
      end
    end
end
