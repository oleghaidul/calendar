class Currency < ActiveRecord::Base
  attr_accessible :country_name, :name

  def name
    country_name
  end

end
