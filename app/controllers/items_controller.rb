class ItemsController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  Composed = Struct.new(:object, :meta)

  def index
    @items = Item.where(user: current_user).all.map { |item| meta(item) }
  end

  def meta(item)
    url = 'https://api.urlmeta.org'
    params = item.link
    resp = Rails.cache.fetch([url, params], expires: 1.hour) do
      Faraday.get(url, {url: params}, {'Authorization' => ENV['URLMETA_KEY']})
    end

    Composed.new(item, JSON.parse(resp.body)['meta'])
  end

  def show
  end

  def new
    @item = Item.new
  end

  def edit
  end

  def create
    @item = Item.new(item_params)

    respond_to do |format|
      if @item.save
        format.html { redirect_to @item, notice: 'Item was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @item.update(item_params)
        format.html { redirect_to @item, notice: 'Item was successfully updated.' }
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
      @selected = Item.tagged_with( params[:name], on: :tags, owned_by: current_user).map { |item| meta(item) }
      respond_to do |format|
          format.js
      end
  end

  private
    def set_item
      @item = Item.find(params[:id])
    end

    def item_params
      params.require(:item).permit(:link, :user_id, :tag_list)
    end
end
