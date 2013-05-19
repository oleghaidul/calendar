class SocialProfilesController < ApplicationController
  load_and_authorize_resource

  def destroy
    @social_profile.destroy
    respond_with @social_profile, location: edit_user_registration_path
  end
end