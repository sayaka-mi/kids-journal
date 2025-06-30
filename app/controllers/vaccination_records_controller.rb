class VaccinationRecordsController < ApplicationController
  before_action :set_vaccination_record, only: [:destroy]

  def index
    @vaccines =Vaccine.all
    @vaccination_records = @current_child.vaccination_records.includes(:vaccine)
  end

  def create_or_update
    records = params[:records]
    
    if records.blank?
      redirect_to child_vaccination_records_path(@current_child), alert: '記録がありません'
      return
    end

    ActiveRecord::Base.transaction do
      records.each do |_, record_params|
        if record_params[:id].present?
          vaccination_record = @current_child.vaccination_records.find(record_params[:id])
          unless vaccination_record.update(record_params.permit(:vaccine_id, :other_vaccine_name, :hospital_name, :memo, :scheduled_date, :completed, :vaccinated_at))
            raise ActiveRecord::Rollback, vaccination_record.errors.full_messages.join(', ')
          end
        else
          new_record = @current_child.vaccination_records.new(record_params.permit(:vaccine_id, :other_vaccine_name, :hospital_name, :memo, :scheduled_date, :completed, :vaccinated_at))
          unless new_record.save
            raise ActiveRecord::Rollback, new_record.errors.full_messages.join(', ')
          end
        end
      end
    end

    redirect_to child_vaccination_records_path(@current_child), notice: '予防接種記録を更新しました！'
  rescue ActiveRecord::RecordInvalid => e
    redirect_to child_vaccination_records_path(@current_child), alert: "バリデーションエラー: #{e.message}"
  rescue => e
    redirect_to child_vaccination_records_path(@current_child), alert: "エラーが発生しました: #{e.message}"
  end

  def destroy
    if @vaccination_record.destroy
      redirect_to child_vaccination_records_path(@current_child), notice: '予防接種記録が削除されました'
    else
      redirect_to child_vaccination_records_path(@current_child)
    end
  end

  private

  def set_vaccination_record
    @vaccination_record = @current_child.vaccination_records.find(params[:id])
  end
end
