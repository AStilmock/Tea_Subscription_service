require 'rails_helper'

RSpec.describe 'Cancel Subscription Request' do
  describe 'request response path' do
    it 'can cancel a tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subscription1 = Subscription.create!(title: "Monthly", price: 10.00)
      cust_sub1 = CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription1.id, status: 0, frequency: "Monthly")

      patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}", params: {cust_sub_id: cust_sub1.id}
      expect(response).to be_successful
      expect(response.status).to eq(201)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to have_key :"Your subscription has been cancelled"
      expect(data[:"Your subscription has been cancelled"]).to have_key :customer_subscription
      expect(data[:"Your subscription has been cancelled"][:customer_subscription]).to be_a Hash
    end

    it 'gets data from response' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      subscription1 = Subscription.create!(title: "Monthly", price: 10.00)
      cust_sub1 = CustomerSubscription.create!(customer_id: customer1.id, subscription_id: subscription1.id, status: 0, frequency: "Monthly")

      patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}", params: {cust_sub_id: cust_sub1.id}
      data = JSON.parse(response.body, symbolize_names: true)[:"Your subscription has been cancelled"]

      expect(data[:customer_subscription][:customer_id]).to eq customer1.id
      expect(data[:customer_subscription][:subscription_id]).to eq subscription1.id
      expect(data[:customer_subscription][:status]).to eq "cancelled"
      expect(data[:customer_subscription][:frequency]).to eq "cancelled"
    end
  end
end