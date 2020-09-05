class ApplicationController < ActionController::Base
  include SessionsHelper
  before_action :set_locale
  protect_from_forgery with: :exception

  private
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

  def default_url_options
    {locale: I18n.locale}
  end

  def logged_in_user
    return if logged_in?
    store_location
    flash[:danger] = t "controllers.users.not_log_in"
    redirect_to login_url
    # ádfsfda
  end
end
