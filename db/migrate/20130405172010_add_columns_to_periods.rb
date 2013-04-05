class AddColumnsToPeriods < ActiveRecord::Migration
  def change
    add_column :periods, :first_name, :string
    add_column :periods, :last_name, :string
    add_column :periods, :adult_guests, :string
    add_column :periods, :children_guests, :string
    add_column :periods, :email, :string
    add_column :periods, :phone, :string
    add_column :periods, :address1, :string
    add_column :periods, :address2, :string
    add_column :periods, :country, :string
    add_column :periods, :city, :string
    add_column :periods, :state, :string
    add_column :periods, :post_code, :string
  end
end
