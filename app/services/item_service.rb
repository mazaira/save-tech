class ItemService
  def initialize(link, tags, user)
    @link = link
    @tags = tags
    @user = user
  end

  def create
    @item = Item.new(link: @link, user: @user)
    @user.tag(@item, with: @tags, on: :tags)

    meta = @item.meta

    @item.update_attributes(
      description: meta['description'],
      image:       meta['image'],
      title:       meta['title'],
    )

    @item
  end
end
