class AddColorToUserCalendars < ActiveRecord::Migration
  def change
    add_column :user_calendars, :color, :string
  end
end
