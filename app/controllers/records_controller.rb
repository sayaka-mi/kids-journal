class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child

  def new
    @record = @child.records.new
  end

  def create
    @record = @child.records.new(record_params)
    if @record.save
      redirect_to child_records_path(@child), notice: '保存しました！'
    else
      render :new
    end
  end

  def index
    @records = @child.records.order(created_at: :desc)
  end

  def show
    @record = @child.records.find(params[:id])
  end

  def edit
  end

  def update
  end

  def destroy
    @record = @child.records.find(params[:id])
    @record.destroy
    redirect_to child_records_path(@child), notice: "削除しました"
  end

  private
  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def record_params
    params.require(:record).permit(:image, :content)
  end
end
