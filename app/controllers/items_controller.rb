class ItemsController < ApplicationController
  include ActionView::Helpers::DateHelper

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.all.map { |item| meta(item) }
  end

  def meta(item)
    url = 'https://api.urlmeta.org'
    params = item.link

    resp = Rails.cache.fetch([url, params], expires: 1.hour) do
      Faraday.get(url, {url: params}, {'Authorization' => ENV['URLMETA_KEY']})
    end

    return item, JSON.parse(resp.body)['meta']
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
        format.json { render :show, status: :ok, location: @item }
      else
        format.html { render :edit }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item.destroy
    respond_to do |format|
      format.html { redirect_to items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
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
