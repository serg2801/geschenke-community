class ApplicationController < ActionController::Base
  protect_from_forgery

  after_filter :store_location

  def store_location
    session[:previous_url] = request.fullpath unless request.fullpath =~ /\/users/
  end

  def after_sign_in_path_for(resource)
    # if current_user.sign_in_count == 1
    #   profile_path
    # else
    #   session[:previous_url] || root_path
    # end
    session[:previous_url] || root_path
  end

  def after_sign_out_path_for(resource)
    session[:previous_url] || root_path
  end
end
