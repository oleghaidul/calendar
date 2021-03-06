class User < ActiveRecord::Base
  extend Enumerize
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :role, :confirmed_at
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

  class << self
    def find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        where(conditions).where(["lower(email) = :value", { value: login.downcase }]).first
      else
        where(conditions).first
      end
    end

    def find_for_oauth(access_token, current_user = nil)
      if auth = SocialProfile.find_by_provider_and_uid(access_token.provider, access_token.uid.to_s)
         auth.user.update_social_profile(access_token)
      elsif current_user
        current_user.add_social_profile(access_token)
      else
        User.new
      end
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
    self.email = social_email
    self.password = Devise.friendly_token
    save
  end

  private
    def send_mail
      Notifier.user_registration_mail(self).deliver
    end
end
