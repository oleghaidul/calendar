class Page < ActiveRecord::Base
  extend Enumerize
  attr_accessible :body, :kind, :title

  enumerize :kind, in: [:home_page]
  validates :kind, presence: true, uniqueness: true
end
