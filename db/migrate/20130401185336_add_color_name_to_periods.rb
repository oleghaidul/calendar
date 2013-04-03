class AddColorNameToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :color_name, :string, default: 'Default'
  end
end
