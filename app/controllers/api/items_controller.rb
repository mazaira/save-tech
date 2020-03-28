class Api::ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def create
    @item = Item.new(link: item_params[:link], user_id: item_params[:user_id])
    if current_user.tag(@item, with: item_params[:tag_list], on: :tags)
      render json: @item
    else
      render json: { error: '422, something went wrong' }
    end
  end

  def show
    render json: @item
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    # TODO: remove user_id as soon as we have auth
    def item_params
      params.require(:item).permit(:link, :user_id, tag_list: [])
    end

    def current_user
      User.first
    end
end
