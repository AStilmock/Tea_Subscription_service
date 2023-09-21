class SubscriptionSerializer
  include JSONAPI::Serializer
  attributes :frequency, :status, :tea
end