class AddPriceToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :price, :integer
  end
end
