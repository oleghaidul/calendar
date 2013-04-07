class AddCurrencyAndCalendarToPricePeriods < ActiveRecord::Migration
  def change
    add_column :price_periods, :user_calendar_id, :integer
    add_column :price_periods, :currency_id, :integer
  end
end
