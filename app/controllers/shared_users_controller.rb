class SharedUsersController < ApplicationController
  def index
    @shared_users = current_user.shared_users.includes(:shared_user)
    if owner_user?
      @child = current_child
    else
      owner = current_user.shared_from_users.first
      @child = owner.children.first if owner.present?
    end
  end

  def create
    unless current_user.children.any?
      redirect_to shared_users_path, alert: 'お子様の情報を登録してから共有してください'
      return
    end

    shared_user = User.find_by(email: params[:email])

    if shared_user.nil?
      redirect_to shared_users_path, alert: '指定したユーザーが見つかりません'
      return
    end

    if shared_user.id == current_user.id
      redirect_to shared_users_path, alert: '自分自身とは共有できません'
      return
    end

    if current_user.shared_users.exists?(shared_user_id: shared_user.id)
      redirect_to shared_users_path, alert: 'すでに共有されています'
      return
    end

    shared_user_record = SharedUser.new(user_id: current_user.id, shared_user_id: shared_user.id)
    if shared_user_record.save
      redirect_to shared_users_path, notice: '共有しました'
    else
      redirect_to shared_users_path
    end
  end

  def destroy
    shared_user = current_user.shared_users.find(params[:id])
    shared_user.destroy
    redirect_to shared_users_path, notice: '共有を解除しました'
  end
end
