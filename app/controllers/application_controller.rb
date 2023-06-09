class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |u|
      u.permit(:name, :last_name, :email, :password, :role, :membership).tap do |params|
        params[:balance] = 300 if params[:role] == "client"
      end
    end

    devise_parameter_sanitizer.permit(:account_update) do |u|
      u.permit(:name, :last_name, :email, :password, :current_password, :role, :membership)
    end
  end
end
