class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    data = session[:social_data] = request.env["omniauth.auth"].except("extra")
    @user = User.find_for_oauth(data, current_user)
    email = data.info.email

    # if social profile alredy exist and current_user == nil then sign in
    # if social profile alredy exist and current_user ==  @user then sign in
    # if social profile alredy exist and current_user !=  @user then
    #  redirect to social_profile_alredy_connected_path
    # if social profile not exist and social network return email then check email for sign-up
    # if social profile not exist and if social network not returns email
    #  then redirect a user on page where he must fill email
    if @user.persisted?
      if @user == current_user || current_user.nil?
        sign_in_user(@user, data.provider)
      else
        flash[:notice] = I18n.t 'omniauth.social_profile_already_connected'
        redirect_to social_profile_already_connected_path
      end
    elsif email
      check_email_for_sign_up(@user, email, data)
    else
      flash[:notice] = I18n.t 'omniauth.enter_email', kind: "#{data.provider}"
      redirect_to fill_email_path
    end
  end

  def setup
    request.env['omniauth.strategy'].options[:client_id] = @site.facebook_key
    request.env['omniauth.strategy'].options[:client_secret] = @site.facebook_secret
    render :text => "Setup complete.", :status => 404
  end

  # verify filling email
  def verify_email
    unless params[:user]
      render :fill_email
      return
    end

    email = params[:user][:email]
    data = session[:social_data]
    @user = User.find_for_oauth(data, current_user)
    # if this email alredy exist then redirect a user on page where he must
    #  fill another email or login with existing account
    # if this email not exist then register a new user
    if email_exist?(email)
      flash[:notice] = I18n.t 'omniauth.this_email_exists', email: email
      redirect_to email_already_exist_path
    else
      unless @user.create_with_social_email!(email)
        render :fill_email
        return
      end

      @user.add_social_profile(data)
      sign_in_user(@user, data.provider)
    end
  end

  private
    def check_email_for_sign_up(user, email, data)
      # if this email alredy exist then redirect a user on page where he must
      #  fill another email or login with existing account
      # if this email not exist then register a new user
      if email_exist?(email)
        flash[:notice] = I18n.t 'omniauth.this_email_exists', email: email
        redirect_to email_already_exist_path
      else
        sign_up_user(user, email, data)
      end
    end

    def sign_up_user(user, email, social_data)
      user.create_with_social_email!(email)
      user.add_social_profile(social_data)
      sign_in_user(user, social_data.provider)
    end

    def sign_in_user(user, provider)
      sign_in_and_redirect user, event: :authentication
      flash[:notice] = I18n.t 'devise.omniauth_callbacks.success', kind: provider
    end

    def email_exist?(email)
      User.find_by_email(email)
    end
end