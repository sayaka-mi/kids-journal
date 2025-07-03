class HeightWeightsController < ApplicationController
  before_action :set_child
  before_action :authenticate_user!

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

  private

  def set_child
    @child = current_user.children.find(params[:child_id])
  end

  def height_weight_params
    params.require(:height_weight).permit(:recorded_on, :height, :weight)
  end
end
