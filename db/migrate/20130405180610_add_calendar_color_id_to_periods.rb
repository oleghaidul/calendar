class AddCalendarColorIdToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :calendar_color_id, :integer
  end
end
