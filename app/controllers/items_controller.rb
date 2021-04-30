class ItemsController < ApplicationController

  before_action :authenticate_user!, only: :new

  def index
  end

  def new
    @item = Item.new
  end

  private
  
  def prototype_params
    params.require(:item).permit(:image, :category, :condirion, :fee, :area, :days, :description, :price).merge(user_id: current_user.id)
  end

end
