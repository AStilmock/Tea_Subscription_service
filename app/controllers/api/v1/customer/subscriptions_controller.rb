class Api::V1::Customer::SubscriptionsController < ApplicationController
  def index
    customer = Customer.find(params[:cust_id])
    render json: { "Customer Tea Subscriptions": customer.subscriptions }, status: 201
  end

  def create
    subscription = Subscription.create!(customer_id: params[:customer_id], tea_id: params[:tea_id], frequency: "Monthly", status: 0 )
    render json: { "Subscription Data": { subscription: subscription, customer: subscription.customer, tea: subscription.tea }}, status: 201
  end

  def update
    subscription = Subscription.find(params[:sub_id])
    subscription.update(status: "cancelled")
    subscription.update(frequency: "cancelled")
    render json: { "Your subscription has been cancelled": { subscription: subscription } }, status: 201
  end
end