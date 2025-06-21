class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_child
  before_action :redirect_to_child_registration_if_none

  def after_sign_in_path_for(resource)
    if resource.children.exists?
      children_path
    else
      new_child_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_current_child
    return unless user_signed_in?
    @current_child = current_user.children.find_by(id: session[:child_id]) || current_user.children.first
  end

  def redirect_to_child_registration_if_none
    return unless user_signed_in?
    return if request.path == new_child_path
    return if request.path.start_with?('/users/sign_out')
    return if request.path.start_with?('/users')

    if current_user.children.empty?
      redirect_to new_child_path, alert: "お子さんの登録をしてね"
      return
    end
  end

  helper_method :current_child
  def current_child
    @current_child
  end

end
