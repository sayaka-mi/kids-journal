class VaccinationRecordsController < ApplicationController
  before_action :set_vaccination_record, only: [:edit, :update, :destroy]

  def index
    @vaccination_records = @current_child.vaccination_records.order(scheduled_date: :desc)
  end

  def new
    @vaccination_record = @current_child.vaccination_records.build
  end

  def create
    @vaccination_record = @current_child.vaccination_records.build(vaccination_record_params)
    if @vaccination_record.save
      redirect_to child_vaccination_records_path(@current_child)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @vaccination_record.update(vaccination_record_params)
      redirect_to child_vaccination_records_path(@current_child), notice: '予防接種記録が更新されました！'
    else
      render :edit, status: :unprocessable_entity
    end
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

  def vaccination_record_params
    params.require(:vaccination_record).permit(:vaccine_id, :other_vaccine_name, :hospital_name, :memo, :scheduled_date, :completed, :vaccinated_at)
  end
end
