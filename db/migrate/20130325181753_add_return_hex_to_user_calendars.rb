class AddReturnHexToUserCalendars < ActiveRecord::Migration
  def change
    add_column :user_calendars, :return_hex, :string
  end
end
