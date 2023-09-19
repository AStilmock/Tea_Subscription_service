class Api::V1::Customer::SubscriptionsController < ApplicationController
  def create
    customer_subscription = CustomerSubscription.create!(customer_id: params[:customer_id], subscription_id: params[:subscription_id])
    render json: customer_subscription, status: 201
    require 'pry'; binding.pry
  end
end