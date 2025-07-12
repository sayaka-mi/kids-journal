class TagsController < ApplicationController
  def index
    tags = if params[:keyword].present?
             Tag.where('name LIKE ?', "%#{params[:keyword]}%").limit(10)
           else
             Tag.none
           end

    render json: tags.select(:id, :name)
  end
end
