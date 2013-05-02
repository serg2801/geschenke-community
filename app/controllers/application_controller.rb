class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :set_locale
  after_filter :store_location

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users|\/admin/
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if current_user.sign_in_count == 1
        "/angemeldet"
      else
        @just_logged_in = true
        session[:previous_url]
      end
    elsif resource.is_a?(AdminUser) 
      # admin_dashboard_path(resource)
      super
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def set_locale
    I18n.locale = :de
  end
  
end
