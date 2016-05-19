class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_ip
  before_filter :set_locale
  after_filter :store_location
  before_filter :prepare_for_mobile
  before_filter :remote_ip

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

  def remote_ip
    if request.remote_ip == '127.0.0.1'
      # Hard coded remote address
      '123.45.67.89'
      new_ip_address(request.remote_ip)
    else
      new_ip_address(request.remote_ip)
    end
  end

  def new_ip_address(ip)
    ip_address = IpAddress.where(ip: ip)
    if ip_address === []
      IpAddress.create(ip: ip)
    end
  end

  def show_modal
    @ip_address = IpAddress.find_by_ip(request.remote_ip)
    @ip_address.update_attributes(mobile: true)
    render json: { }
  end

  def get_ip
    @ip_address = IpAddress.find_by_ip(request.remote_ip)
    @mobile = @ip_address.mobile
  end

  private

  def mobile_device?
    if session[:mobile_param]
      session[:mobile_param] == "1"
    else
      request.user_agent =~ /Mobile|webOS/
    end
  end
  helper_method :mobile_device?

  def prepare_for_mobile
    session[:mobile_param] = params[:mobile] if params[:mobile]
    request.format = :mobile if mobile_device?
  end
  
end
