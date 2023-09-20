require 'rails_helper'

RSpec.describe 'View All Customer Subscriptions' do
  describe 'view all customer subscriptions request/response path' do
    it 'can view all customer subscriptions' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subscription1 = Subscription.create!(title: "Monthly", price: 10.00)
      cust_sub1 = CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription1.id, status: 0, frequency: "Monthly")

      get "/api/v1/customers/#{customer1.id}/subscriptions"
      expect(response).to be_successful
      expect(response.status).to eq 201
      expect(customer1.subscriptions.count).to eq 1
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key :"Customer Subscriptions"
      expect(data[:"Customer Subscriptions"]).to be_a Array
      expect(data[:"Customer Subscriptions"].first[:id]).to eq subscription1.id
      expect(data[:"Customer Subscriptions"].first[:title]).to eq subscription1.title
      expect(data[:"Customer Subscriptions"].first[:price]).to eq subscription1.price
    end
  end
end