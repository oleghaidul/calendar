class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role
  # attr_accessible :title, :body

  enumerize :role, in: [:user, :admin], default: :user

  has_many :user_calendars
  has_many :social_profiles, dependent: :destroy

  after_create :send_mail

  SocialProfile.provider.values.each do |provider|
    define_method(provider) do
      social_profiles.send(provider).first
    end
  end

  def add_social_profile(access_token)
    profile = social_profiles.create!( provider: access_token.provider,
                                       uid: access_token.uid,
                                       token: access_token.credentials.token )
    self
  end

  def update_social_profile(access_token)
    self.send(access_token.provider.to_sym).
      update_attributes({token: access_token.credentials.token, is_token_valid: true})
    self
  end

  def create_with_social_email!(social_email)
    self.email = self.username = social_email
    self.password = Devise.friendly_token
    save
  end

  private
    def send_mail
      Notifier.user_registration_mail(self).deliver
    end
end
