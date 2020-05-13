class ItemsController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.where(user: current_user).order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = init_service.create
    if @item.persisted?
      redirect_to items_url
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    respond_to do |format|
      if init_service.update(@item)
        format.html { redirect_to items_url, notice: 'Item was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    end
  end

  def from_tag
    @items = Item.with_tag( params[:name], current_user)
    @active_tags = params[:name]

    respond_to { |format| format.js }
  end

  def pending_to_filter
    @items = (Item.where(user: current_user) - Item.joins(:taggings).where(user: current_user).uniq)

    respond_to { |format| format.js }
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:link, :user_id, :tag_list)
    end

    def init_service
      ::ItemService.new(item_params[:link], item_params[:tag_list], current_user)
    end
end
