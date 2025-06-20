class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child
  before_action :set_record, only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if params[:record][:remove_images].present?
      params[:record][:remove_images].each do |blob_id|
        image = @record.images.find_by(blob_id: blob_id)
        image.purge if image
      end
    end

    if @record.update(record_params.except(:images))
      if params[:record][:images].present?
        params[:record][:images].each do |image|
          @record.images.attach(image)
        end
      end
      redirect_to child_records_path(@child), notice: '更新しました！'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @record.destroy
    redirect_to child_records_path(@child), notice: "削除しました"
  end

  private
  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def record_params
    params.require(:record).permit(:content, images: [])
  end

  def set_record
    @record = @child.records.find(params[:id])
  end

end
