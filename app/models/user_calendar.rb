class UserCalendar < ActiveRecord::Base
  attr_accessible :active, :name, :paid, :periods_attributes

  has_many :periods, foreign_key: :calendar_id
  accepts_nested_attributes_for :periods
  validates :name, presence: true

  def paypal_url(return_url)
    return_hex = SecureRandom.hex(10)
    update_attribute(:return_hex, return_hex)

    values = {
      :business => 'calendar@gmail.com',
      :cmd => '_cart',
      :upload => 1,
      :return => return_url + "?return_hex=#{return_hex}",
      :invoice => id,
      :amount_1 => 13,
      :item_name_1 => 'Calendar',
      :item_number_1 => id,
      :quantity_1 => 1
    }

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def make_paid
    update_attribute(:paid, true)
  end

  def process(day)
    if Date === day
      period = periods.where { (start_date <= day) & (end_date >= day) }.first
      start_period = periods.where(start_date: day).first
      end_period = periods.where(end_date: day).first
      if start_period && end_period
        {status: 'bouth', period_id: [start_period.id, end_period.id], color: [start_period.color, end_period.color]}
      elsif period
        period.day = day
        period.process
      else
        {status: 'not_found'}
      end
    end
  end
end
