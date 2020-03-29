class ItemService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def create
    @item = Item.new(link: @params[:link], user: @user)
    @user.tag(@item, with: @params[:tag_list], on: :tags)

    @item
  end
end
