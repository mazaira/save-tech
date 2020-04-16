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
    @item = ::ItemService.new(item_params, current_user)

    if @item.create
      redirect_to items_url
    else
      raise
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
    end
  end

  def from_tag
    @selected = Item.tagged_with( params[:name], on: :tags, owned_by: current_user).map { |item| meta(item) }
    @active_tags = params[:name]

    respond_to { |format| format.js }
  end

  def pending_to_filter
    @selected = (Item.where(user: current_user) - Item.joins(:taggings).where(user: current_user).uniq).map { |item| meta(item) }

    respond_to { |format| format.js }
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:link, :user_id, :tag_list)
    end

  ## Scaffold but not supported yet
  # def update
  #   respond_to do |format|
  #     if @item.update(item_params)
  #       format.html { redirect_to @item, notice: 'Item was successfully updated.' }
  #     else
  #       format.html { render :edit }
  #     end
  #   end
  # end

end
