class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :ensure_valid_email

  before_filter :set_locale

  def ensure_valid_email
    if current_user.nil?
      if request.env['PATH_INFO'] != '/users/sign_in'
        flash[:error] = 'Please login first'
        redirect_to '/users/sign_in'
      end
    else
      has_invalid_email = (current_user.email == User::INVALID_EMAIL)
      allowed_paths = [destroy_user_session_path, edit_user_path(current_user), user_path(current_user)].map { |x| x.split('?locale=')[0]}
      visits_allowed_path = allowed_paths.include?(request.env['PATH_INFO'].split('?locale=')[0])
      if has_invalid_email && !visits_allowed_path
        flash[:error] = 'Please set a valid email address first'
        redirect_to edit_user_path(current_user)
      end
    end
  end

  #before_action :authenticate_user!

  private
    def set_locale
      if current_user
        if I18n.locale !=  current_user.language
          I18n.locale =  current_user.language
        end
      else
        I18n.locale = I18n.default_locale
      end 
    end

    def default_url_options(options = {})
      {locale: I18n.locale}
    end
end
