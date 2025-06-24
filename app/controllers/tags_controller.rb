class TagsController < ApplicationController
  def index
    if params[:keyword].present?
      tags = Tag.where("name LIKE ?", "%#{params[:keyword]}%").limit(10)
    else
      tags = Tag.none
    end

    render json: tags.select(:id, :name)
  end
end
