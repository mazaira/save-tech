class BaseSerializer
  include JSONAPI::Serializer

  def links
    []
  end
end
