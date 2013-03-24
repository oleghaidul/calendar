SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    if user_signed_in?
      primary.item :sign_out, 'Sign Out', destroy_user_session_path, method: :delete
      primary.item :edit_profile, 'Edit Profile', edit_user_registration_path
      primary.item :calendars, 'My calendars', calendars_path, highlights_on: proc { @calendars || @calendar }
    else
      primary.item :login, 'Sign In', new_user_session_path
      primary.item :sign_up, 'Sign Up', new_user_registration_path
    end
    primary.dom_class = 'nav'
  end
end