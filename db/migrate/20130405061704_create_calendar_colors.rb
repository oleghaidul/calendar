class CreateCalendarColors < ActiveRecord::Migration
  def change
    create_table :calendar_colors do |t|
      t.string :color_name
      t.string :color_hash
      t.integer :user_calendar_id

      t.timestamps
    end
  end
end
