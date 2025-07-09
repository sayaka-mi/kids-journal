class VaccinationRecordsController < ApplicationController
  before_action :set_vaccination_record, only: [:destroy]
  before_action :set_child
  before_action :ensure_owner_user, only: [:create_or_update, :destroy]

  def index
    @vaccines =Vaccine.all
    @vaccination_records = @child.vaccination_records.includes(:vaccine)
  end

  def create_or_update
    records_params = params.require(:"[vaccination_records]").permit!
    processed_records_params = records_params.values.map do |record_param|
      record_param = record_param.permit(:id, :vaccine_id, :vaccinated_at, :hospital_name, :memo, :completed)
      record_param[:vaccinated_at] = nil if record_param[:vaccinated_at].blank?
      record_param
    end

    processed_records_params.each do |record_param|
      if record_param[:id].present?
        record = @child.vaccination_records.find_by(id: record_param[:id])
        if record
          record.update(record_param)
        end
      else
        @child.vaccination_records.create(record_param)
      end
    end

    redirect_to child_vaccination_records_path(@child), notice: '予防接種記録を保存しました。'
  rescue ActionController::ParameterMissing => e
    flash[:alert] = "必要な情報が入力されていません。もう一度ご確認ください。"
    redirect_to child_vaccination_records_path(@child)
  end

  def destroy
    if @vaccination_record.destroy
      redirect_to child_vaccination_records_path(@child), notice: '予防接種記録が削除されました'
    else
      redirect_to child_vaccination_records_path(@child)
    end
  end

  private

  def set_vaccination_record
    @vaccination_record = @current_child.vaccination_records.find(params[:id])
  end

  def set_child
    @child = all_children.find { |c| c.id == params[:child_id].to_i }
  end

  def ensure_owner_user
    unless owner_user?
      redirect_to root_path, alert: "この操作はできません（閲覧専用です）"
    end
  end
end
