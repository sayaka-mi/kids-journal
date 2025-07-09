class SharedUsersController < ApplicationController
  def index
    @shared_users = current_user.shared_users.includes(:shared_user)
  end

  def create
    shared_user = User.find_by(email: params[:email])

    if shared_user.nil?
      redirect_to shared_users_path, alert: "指定したユーザーが見つかりません"
      return
    end

    if shared_user.id == current_user.id
      redirect_to shared_users_path, alert: "自分自身とは共有できません"
      return
    end

    if current_user.shared_users.exists?(shared_user_id: shared_user.id)
      redirect_to shared_users_path, alert: "すでに共有されています"
      return
    end

    SharedUser.create(user_id: current_user.id, shared_user_id: shared_user.id)
    if shared_user_record.save
      redirect_to shared_users_path, notice: "共有しました"
    else
      redirect_to shared_users_path
    end
  end

  def destroy
    shared_user = current_user.shared_users.find(params[:id])
    shared_user.destroy
    redirect_to shared_users_path, notice: "共有を解除しました"
  end
end
