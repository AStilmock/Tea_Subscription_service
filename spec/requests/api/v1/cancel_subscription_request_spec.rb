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
      expect(data).to have_key :"Your subscription has been cancelled"
      expect(data[:"Your subscription has been cancelled"]).to have_key :subscription
      expect(data[:"Your subscription has been cancelled"][:subscription]).to be_a Hash
    end

    it 'gets data from response' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      subscription1 = Subscription.create!(customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0)

      patch "/api/v1/customers/#{customer1.id}/subscriptions/#{subscription1.id}"
      data = JSON.parse(response.body, symbolize_names: true)[:"Your subscription has been cancelled"]

      expect(data[:subscription][:customer_id]).to eq customer1.id
      expect(data[:subscription][:tea_id]).to eq tea1.id
      expect(data[:subscription][:frequency]).to eq "cancelled"
      expect(data[:subscription][:status]).to eq "cancelled"
    end
  end
end