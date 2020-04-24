class Item < ApplicationRecord
  belongs_to :user

  has_many :taggings, class_name: 'ActsAsTaggableOn::Tagging', dependent: :destroy
  acts_as_taggable

  def meta
    resp = Faraday.get(ENV['META_URL'], {url: self.link}, {'Authorization' => ENV['META_KEY']})

    JSON.parse(resp.body)['meta']
  end

  def add_tag(tags)
    self.user.tag(self, with: tags, on: :tags)
  end

  def tag_list
    tags.join(", ")
  end
end
