class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :basic_auth if Rails.env.production?
  before_action :search_mariage

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname])
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD']
    end
  end

  def search_mariage
    @p = Mariage.ransack(params[:q])
    @category = Category.where.not(id: 1)
    @taste = Taste.where.not(id: 1)
  end
end
