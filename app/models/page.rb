class Page < ActiveRecord::Base
  extend Enumerize
  attr_accessible :body, :kind, :title

  enumerize :kind, in: [:home_page, :contact_us]
  validates :kind, presence: true, uniqueness: true
end
