class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_child, except: [:search]
  before_action :set_record, only: [:edit, :update, :destroy]

  def new
    @record = @child.records.new
  end

  def create
    @record = @child.records.new(record_params)

    if params[:tag_names].present?
      new_tag_ids = params[:tag_names].map do |tag_name|
        Tag.find_or_create_by(name: tag_name.strip).id
      end
      @record.tag_ids += new_tag_ids
    end

    if @record.save
      redirect_to child_records_path(@child), notice: '保存しました！'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @records = @child.records.includes(:tags, images_attachments: :blob).order(created_at: :desc)
  end

  def edit
    @record = @child.records.includes(:tags).find(params[:id])
  end

  def update
    if params[:record][:remove_attachments].present?
      params[:record][:remove_attachments].each do |blob_id|
        attachment = @record.images.find_by(blob_id: blob_id)
      attachment.purge if attachment
      end
    end

    if params[:tag_names].present?
      new_tag_ids = params[:tag_names].map do |tag_name|
        Tag.find_or_create_by(name: tag_name.strip).id
      end
      existing_tag_ids = (record_params[:tag_ids] || []).reject(&:blank?).map(&:to_i)
      @record.tag_ids = existing_tag_ids + new_tag_ids
    else
      @record.tag_ids = (record_params[:tag_ids] || []).reject(&:blank?).map(&:to_i)
    end

    if @record.update(record_params.except(:attachments, :tag_ids))
      if params[:record][:attachments].present?
        params[:record][:attachments].each do |attachment|
          @record.images.attach(attachment)
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

  def search
    tag_names = params[:tag_names]
    content = params[:content]
    child_ids = current_user.children.pluck(:id)

    if tag_names.blank? && content.blank?
      @records = Record.none
    else
      @records = Record.search(child_ids: child_ids, tag_names: tag_names, content: content)
    end
  end

  private
  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def record_params
    params.require(:record).permit(:content, images: [], tag_ids: [])
  end

  def set_record
    @record = @child.records.find(params[:id])
  end

end
