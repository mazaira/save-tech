class Item < ApplicationRecord
  belongs_to :user

  has_many :taggings, class_name: 'ActsAsTaggableOn::Tagging', dependent: :destroy

  validates :link, url: true
  validates :image, url: { allow_blank: true }

  acts_as_taggable

  def meta
    resp = Faraday.get(ENV['META_URL'], {url: self.link}, {'Authorization' => ENV['META_KEY']})

    JSON.parse(resp.body)['meta']
  end

  require 'open-uri'
  def noko(item)
    doc = Nokogiri::HTML(URI.open(item.link))

    title = doc.search('title').text
    description, image = doc.search("meta[name='description'], meta[property='og:image'], meta[property='og:image:secure_url']").map { |n| n['content'] }.compact

    [title, description, image]
  end

  def add_tag(tags)
    user.tag(self, with: tags, on: :tags)
  end

  def tag_list
    tags.join(', ')
  end

  def self.with_tag(name, user)
    Item.tagged_with(name, on: :tags, owned_by: user)
  end
end
