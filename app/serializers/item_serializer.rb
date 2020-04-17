class ItemSerializer
    include JSONAPI::Serializer

    attribute :id
    attribute :link
    attribute :description
    attribute :image
    attribute :title

    attribute :tags do
      object.tag_list.split(', ')
    end
end
