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
    return @item unless meta

    @item.update(description: meta['description'], title: meta['title'])
    @item.update(image: meta['image'])

    @item
  end

  def update(item)
    item.update_attributes(link: @link)
    @user.tag(item, with: @tags, on: :tags)
  end
end
