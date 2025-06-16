class ChildrenController < ApplicationController
  before_action :authenticate_user!

  def new
    @child = Child.new
  end

  def create
    @child = current_user.children.build(child_params)
    if @child.save
      redirect_to children_path
    else
      render :new
    end
  end

  def index
    @children = current_user.children
  end

  def destroy
    @child = current_user.children.find(params[:id])
    if @child.delete
      redirect_to children_path
    else
      redirect_to children_path
    end
  end

  private

  def child_params
    params.require(:child).permit(:name, :birthday, :gender, :allergy_info, :blood_type)
  end

end