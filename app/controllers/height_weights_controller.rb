class HeightWeightsController < ApplicationController
  before_action :set_child
  before_action :authenticate_user!
  before_action :set_height_weight, only: [:edit, :update, :destroy]
  before_action :ensure_owner_user, only: [:new, :create, :edit, :update, :destroy]

  def new
    @height_weight = @child.height_weights.build
  end

  def create
    @height_weight = @child.height_weights.build(height_weight_params)
    if @height_weight.save
      redirect_to child_height_weights_path(@child)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def index
    @height_weights = @child.height_weights.order(recorded_on: :desc)
  end

  def edit
  end

  def update
    if @height_weight.update(height_weight_params)
      redirect_to child_height_weights_path(@child)
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @height_weight.destroy
    redirect_to child_height_weights_path(@child)
  end

  def chart
    @height_weights = @child.height_weights.order(:recorded_on)
    @height_percentiles = HeightWeightStandardData.series_for(@child, 'height')
    @weight_percentiles = HeightWeightStandardData.series_for(@child, 'weight')
  end

  private

  def set_child
    @child = all_children.find { |c| c.id == params[:child_id].to_i }
  end

  def height_weight_params
    params.require(:height_weight).permit(:recorded_on, :height, :weight)
  end

  def set_height_weight
    @height_weight = @child.height_weights.find(params[:id])
  end

  def ensure_owner_user
    return if owner_user?

    redirect_to root_path, alert: 'この操作はできません（閲覧専用です）'
  end
end
