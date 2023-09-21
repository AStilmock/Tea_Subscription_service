class Api::V1::Customer::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:cust_id])
    if customer.subscriptions == []
      render json: { error: "Customer has no subscriptions" }, status: 404
    else
      subs = customer.subscriptions
      render json: SubscriptionSerializer.new(subs), status: 201
    end
  end

  def create
    subscription = Subscription.new(customer_id: params[:customer_id], tea_id: params[:tea_id], frequency: params[:frequency], status: "active" )
    if subscription.save 
      render json: { success: "Your subscription has been created" }, status: 201
    else
      render json: { error: "Subscription not created" }, status: 404
    end
  end

  def update
    subscription = Subscription.find(params[:sub_id])
    if subscription.status == "cancelled"
      render json: { error: "Subscription already cancelled" }, status: 404
    else
      subscription.update(status: "cancelled", frequency: "cancelled")
      render json: { success: "Your subscription has been cancelled" }, status: 201
    end
  end
end