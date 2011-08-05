class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_locale
  
  def require_is_admin
    unless ( current_user && current_user.is_admin )
      flash[:alert] = "You must be admin"
      redirect_to root_path
    end
  end

  def set_locale
    # 可以將 ["en", "zh-TW"] 設定為 VALID_LANG 放到 config/environment.rb 中
    if params[:locale] && I18n.available_locales.include?( params[:locale].to_sym )
      session[:locale] = params[:locale]
    end

    I18n.locale = session[:locale] || I18n.default_locale
  end
end
