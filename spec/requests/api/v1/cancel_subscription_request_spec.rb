require 'rails_helper'

RSpec.describe 'Cancel Subscription Request' do
  describe 'request response path' do
    it 'can cancel a tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0)

      patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
      expect(response).to be_successful
      expect(response.status).to eq(201)
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to be_a Hash
      expect(data).to eq({ success: "Your subscription has been cancelled" })
      subscription1.reload
      expect(subscription1.status).to eq("cancelled")
      expect(subscription1.frequency).to eq("cancelled")
    end

    it 'subscription already cancelled' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 1)
      patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to eq({:error=>"Subscription already cancelled"})
    end
  end
end