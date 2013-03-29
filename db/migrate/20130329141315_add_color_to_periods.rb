class AddColorToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :color, :string, default: "#ff0000"
  end
end
