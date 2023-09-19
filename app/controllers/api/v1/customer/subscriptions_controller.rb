class Api::V1::Customer::SubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.create!(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
    render json: { "Subscription Data": { customer: customer_subscription.customer, subscription: customer_subscription.subscription }}, status: 201
  end
end