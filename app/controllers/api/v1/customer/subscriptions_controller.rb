class Api::V1::Customer::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:cust_id])
    render json: { "Customer Subscriptions": customer.subscriptions }, status: 201
  end

  def create
    customer_subscription = CustomerSubscription.create!(customer_id: params[:customer_id], subscription_id: params[:subscription_id], status: 0, frequency: "Monthly" )
    render json: { "Subscription Data": { customer_subscription: customer_subscription, customer: customer_subscription.customer, subscription: customer_subscription.subscription }}, status: 201
  end

  def update
    cust_sub = CustomerSubscription.find(params[:cust_sub_id])
    cust_sub.update(status: "cancelled")
    cust_sub.update(frequency: "cancelled")
    render json: { "Your subscription has been cancelled": { customer_subscription: cust_sub } }, status: 201
  end
end