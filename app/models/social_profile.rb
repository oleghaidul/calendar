class SocialProfile < ActiveRecord::Base
  extend Enumerize
  AVAILABLE_SOCIAL_NETWORKS = %w[facebook]

  belongs_to :user

  attr_accessible :provider, :token, :uid, :is_token_valid
  attr_accessor :is_token_valid
  enumerize :provider, in: AVAILABLE_SOCIAL_NETWORKS

  provider.values.each do |provider|
    scope provider.to_sym, where(provider: provider)
  end
end
