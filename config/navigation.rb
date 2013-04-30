SimpleNavigation::Configuration.run do |navigation|
  navigation.items do |primary|
    if user_signed_in?
      primary.item :sign_out, 'Sign Out', destroy_user_session_path, method: :delete
      primary.item :edit_profile, 'Edit Profile', edit_user_registration_path
      primary.item :calendars, 'My calendars', calendars_path, highlights_on: proc { (@calendars || @calendar) && action_name != 'list' }
      primary.item :calendars_list, 'Calendars list', list_calendars_path, highlights_on: proc { (@calendars || @calendar) && action_name == 'list' }
      primary.item :pages, 'Pages', pages_path, highlights_on: proc { @pages || @page } if can? :manage, Page
      primary.item :admin, 'Admin panel', rails_admin_path if can? :access, :rails_admin
    else
      primary.item :login, 'Sign In', new_user_session_path
      primary.item :sign_up, 'Sign Up', new_user_registration_path
    end
    primary.item :contact_us, 'Contact Us', 'mailto:info@viclizgroup.com' if controller_name == 'home'
    primary.dom_class = 'nav'
  end
end