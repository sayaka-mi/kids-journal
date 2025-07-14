class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_current_child, , unless: :skip_set_current_child?
  before_action :redirect_to_child_registration_if_none, unless: :devise_controller?

  def after_sign_in_path_for(resource)
    if resource.children.exists?
      children_path
    elsif SharedUser.exists?(shared_user_id: resource.id)
      children_path
    else
      new_child_path
    end
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  private

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_current_child
    return unless user_signed_in?

    own_children = current_user.children
    shared_from_users = SharedUser.where(shared_user_id: current_user.id).pluck(:user_id)
    shared_children = Child.where(user_id: shared_from_users)

    all_children = own_children + shared_children
    session[:child_id] ||= all_children.first&.id
    @current_child = all_children.find { |c| c.id == session[:child_id] } || all_children.first
  end

  def redirect_to_child_registration_if_none
    return unless user_signed_in?
    return if controller_name == 'children' && action_name == 'new'
    return if devise_controller?
    return if request.path == destroy_user_session_path

    if current_user.children.empty? && !SharedUser.exists?(shared_user_id: current_user.id)
      redirect_to new_child_path, alert: 'お子様の情報を登録してください。'
    end
  end

  def skip_set_current_child?
    !user_signed_in? ||
      devise_controller? ||
      (controller_name == 'children' && action_name == 'new') ||
      (current_user && current_user.children.empty? && !SharedUser.exists?(shared_user_id: current_user.id))
  end

  helper_method :all_children
  def all_children
    return [] unless user_signed_in?

    own_children = current_user.children
    shared_from_users = SharedUser.where(shared_user_id: current_user.id).pluck(:user_id)
    shared_children = Child.where(user_id: shared_from_users)

    own_children + shared_children
  end

  helper_method :current_child
  attr_reader :current_child

  helper_method :owner_user?
  def owner_user?
    user_signed_in? && current_child && current_user.children.exists?(id: current_child.id)
  end

  helper_method :shared_user?
  def shared_user?
    user_signed_in? && current_child && !current_user.children.exists?(id: current_child.id)
  end
end
