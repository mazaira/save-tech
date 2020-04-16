class Item < ApplicationRecord
  belongs_to :user

  acts_as_taggable

  def tag_list
    tags.join(", ")
  end

  def meta
    resp = Faraday.get(ENV['META_URL'], {url: self.link}, {'Authorization' => ENV['META_KEY']})

    JSON.parse(resp.body)['meta']
  end
end
