class Api::ItemsController < Api::BaseController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def create
    item = ::ItemService.new(item_params, current_user).create
    if item
      render json: JSONAPI::Serializer.serialize(item)
    else
      render json: { error: '422, something went wrong' }
    end
  end

  def show
    render json:  JSONAPI::Serializer.serialize(@item)
  end

  def update
    current_user.tag(@item, with: item_params[:tags], on: :tags)
    render json:  JSONAPI::Serializer.serialize(@item)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  # TODO: remove user_id as soon as we have auth
  def item_params
    params.require(:data).require(:attributes).permit(:link, :user_id, tags: [])
  end
end
