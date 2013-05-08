class UserCalendar < ActiveRecord::Base
  attr_accessible :active, :name, :paid, :periods_attributes, :color, :user_id, :trial, :trial_to, :paid_to

  has_many :periods, foreign_key: :user_calendar_id, dependent: :destroy
  has_many :calendar_colors, dependent: :destroy
  has_many :periods_colors, through: :periods, source: :calendar_color, uniq: true, dependent: :destroy

  has_many :price_periods, dependent: :destroy

  accepts_nested_attributes_for :periods
  validates :name, presence: true
  belongs_to :user

  after_create :create_notification

  def paypal_url(return_url, notify_url)
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
      :quantity_1 => 1,
      :notify_url => notify_url
    }

    "https://www.sandbox.paypal.com/cgi-bin/webscr?" + values.to_query
  end

  def make_paid
    update_attribute(:paid, true)
    update_attribute(:paid_to, Date.today+1.year)
    update_attribute(:trial, false)
    Notifier.calendar_payment(self).deliver
    Notifier.calendar_payment_user(self).deliver
  end

  private
    def create_notification
      Notifier.calendar_create(self).deliver
      Notifier.calendar_create_user(self).deliver
    end

    def self.check_trial
      @calendars = UserCalendar.where(trial: true)
      @calendars.each do |calendar|
        if calendar.trial_to.to_date == Date.today
          calendar.update_attribute(:trial, false)
          Notifier.trial(calendar).deliver
        elsif calendar.trial_to.to_date == Date.today-1
          Notifier.trial_end(calendar).deliver
        end
      end
    end

    def self.check_paid
      @calendars = UserCalendar.where(paid: true)
      @calendars.each do |calendar|
        if calendar.paid_to.any? && calendar.paid_to < Date.today
          calendar.update_attribute(:paid, false)
          Notifier.paid_end(calendar).deliver
        elsif calendar.paid_to.any? && calendar.paid_to.to_date == Date.today-7
          Notifier.paid_end(calendar).deliver
        elsif calendar.paid_to.any? && calendar.paid_to.to_date == Date.today-1
          Notifier.paid_end(calendar).deliver
        end
      end
    end
end
