class RegistrationsController < Devise::RegistrationsController
  layout "login"

  def create
    build_resource

    if resource.save
      resource.add_social_profile(session["devise.social_data"]) if session["devise.social_data"]

      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_in(resource_name, resource)
        respond_with resource, location: after_sign_up_path_for(resource)
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
        respond_with resource, location: after_inactive_sign_up_path_for(resource)
      end
    else
      clean_up_passwords resource
      build_flash(resource)
      respond_with resource
    end
  end

  private
    def build_flash(resource)
      if User.where(email: resource.email).any?
        set_flash_message :error, :exist_in_database
      else
        set_flash_message :error, :password_not_match
      end
    end
end