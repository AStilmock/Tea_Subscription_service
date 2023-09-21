class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :frequency, :status, :tea

  def tea
    Tea.find(object.tea_id)
  end
end