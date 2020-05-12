class Api::TagsController < Api::BaseController
  def index
    tags = current_user.owned_tags.order('taggings_count DESC').map(&:name)
    render json: { data: { type: 'tags', attributes: tags}}
  end

  def most_used
    tags = current_user.owned_tags.order('taggings_count DESC').first(5).pluck(:name)
    render json: { data: { type: 'tags', attributes: tags}}
  end
end
