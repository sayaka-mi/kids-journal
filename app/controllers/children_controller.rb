class ChildrenController < ApplicationController
  before_action :authenticate_user!
  skip_before_action :redirect_to_child_registration_if_none, only: [:new, :create]
  before_action :set_child, only: [:edit, :update, :destroy, :vaccination_schedule]
  before_action :ensure_owner_user, only: [:edit, :update, :destroy]

  def index
    @children = all_children
  end

  def new
    @child = Child.new
  end

  def create
    @child = current_user.children.new(child_params)
    if @child.save
      session[:child_id] = @child.id
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
    child = all_children.find { |c| c.id == params[:child_id].to_i }
    session[:child_id] = child.id
    redirect_to root_path, notice: "#{child.name} を選択しました"
  end

  def vaccination_schedule
    @vaccines = Vaccine.all
    @vaccination_schedules = @vaccines.map do |vaccine|
      next if vaccine.dose_month.blank?

      schedule_dates = vaccine.dose_months.map do |month|
        @child.birthday.advance(months: month)
      end

      {
        vaccine: vaccine,
        schedule_dates: schedule_dates
      }
    end.compact
  end

  private

  def set_child
    @child = all_children.find { |c| c.id == params[:id].to_i }
  end

  def child_params
    params.require(:child).permit(:name, :birthday, :gender, :allergy_info, :blood_type)
  end

  def ensure_owner_user
    return if owner_user?

    redirect_to root_path, alert: 'この操作はできません（閲覧専用です）'
  end
end
