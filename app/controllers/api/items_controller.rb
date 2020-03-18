class Api::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def create
    @item = Item.new(item_params)

    if @item.save
      render json: @item
    else
      render json: { error: '422, something went wrong' }
    end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:link)
    end
end
