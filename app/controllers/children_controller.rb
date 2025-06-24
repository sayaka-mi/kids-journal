class ChildrenController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child, only: [:edit, :update, :destroy]

  def index
    @children = current_user.children
  end

  def new
    @child = Child.new
  end

  def create
    @child = current_user.children.new(child_params)
    if @child.save
      redirect_to children_path, notice: '登録しました！'
    else
      Rails.logger.debug "== errors: #{@child.errors.full_messages} =="
      render :new
    end
  end

  def edit
  end

  def update
    if @child.update(child_params)
      redirect_to children_path, notice: '更新しました！'
    else
      render :edit
    end
  end

  def destroy
    if @child.destroy
      redirect_to children_path, notice: '削除しました！'
    else
      redirect_to children_path, notice: '削除に失敗しました！'
    end
  end

  def select_child
    child = current_user.children.find(params[:child_id])
    session[:child_id] = child.id
    redirect_to root_path, notice: "#{child.name} を選択しました"
  end

  private

  def set_child
    @child = current_user.children.find(params[:id])
  end

  def child_params
    params.require(:child).permit(:name, :birthday, :gender, :allergy_info, :blood_type)
  end

end