class Api::TagsController < Api::BaseController
  def most_used
    tags = current_user.owned_tags.order('taggings_count DESC').first(6).pluck(:name)
    render json: { data: { type: 'tags', attributes: tags}}
  end
end
