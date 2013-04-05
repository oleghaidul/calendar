class UserCalendar < ActiveRecord::Base
  attr_accessible :active, :name, :paid, :periods_attributes, :color

  has_many :periods, foreign_key: :user_calendar_id
  has_many :calendar_colors
  accepts_nested_attributes_for :periods
  validates :name, presence: true
  belongs_to :user

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
  end
end
