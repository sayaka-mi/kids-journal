class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_child
  before_action :redirect_to_child_registration_if_none, unless: :devise_controller?

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

    if session[:child_id].present?
      @current_child = current_user.children.find_by(id: session[:child_id])
    end

    @current_child ||= current_user.children.first
  end

  def redirect_to_child_registration_if_none
    return unless user_signed_in?
    return if controller_name == "children" && action_name == "new"
    return if devise_controller?
    return if request.path == destroy_user_session_path

    if @current_child.nil? && current_user.children.empty?
      redirect_to new_child_path, alert: "お子様の情報を登録してください。"
      return
    end
  end

  helper_method :current_child
  def current_child
    @current_child
  end

end
