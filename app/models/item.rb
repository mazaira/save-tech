class Item < ApplicationRecord
  belongs_to :user

  acts_as_taggable

  def tag_list
    tags.join(", ")
  end
end
