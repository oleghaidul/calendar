class CreateUserCalendars < ActiveRecord::Migration
  def change
    create_table :user_calendars do |t|
      t.string :name
      t.boolean :active, default: true
      t.boolean :paid, default: false

      t.timestamps
    end
  end
end
