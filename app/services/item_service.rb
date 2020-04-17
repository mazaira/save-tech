class ItemService
  def initialize(params, user)
    @params = params
    @user = user
  end

  def create
    @item = Item.new(link: @params[:link], user: @user)
    @user.tag(@item, with: @params[:tags], on: :tags)

    meta = @item.meta

    @item.update_attributes(
      description: meta['description'],
      image:       meta['image'],
      title:       meta['title'],
    )

    @item
  end
end
