class Period < ActiveRecord::Base
  attr_accessible :calendar_id, :end_date, :info, :note, :period_type, :start_date
  attr_accessor :day
  belongs_to :calendar

  def self.process(calendar_id, day)
    if Date === day
      calendar = Calendar.find(calendar_id)
      period = calendar.periods.where { (start_date <= day) & (end_date >= day) }.first
      if period
        period.day = day
        {status: period.status, color: period.color, period_id: period.id}
      else
        {status: 'not_found'}
      end
    end
  end

  def status
    if start?
      'start'
    elsif end?
      'end'
    else
      'between'
    end
  end

  private

    def start?
      period.start_date == day
    end

    def end?
      period.end_date == day
    end
end
