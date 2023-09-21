require 'rails_helper'

RSpec.describe 'New Tea Subscription Request' do
  describe 'request response path' do
    it 'can create a new tea subscription' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      expect(customer1.teas.count).to eq 0
      
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, tea_id: tea1.id, frequency: "Monthly", status: 0}
      subscription = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(201)
      expect(subscription).to be_a Hash
      expect(subscription).to have_key :success
      expect(subscription[:success]).to eq "Your subscription has been created"
      expect(customer1.teas.count).to eq 1
    end

    it 'data error sad path' do
      customer1 = Customer.create!(first_name: "Billy", last_name: "Bob", email: "billybobsemail@email.com", address: "123 billy bob lane")
      tea1 = Tea.create!(title: "Bobs and Weaves", description: "A tea that will make you bob and weave", temperature: 200, brew_time: 5)
      post "/api/v1/customers/#{customer1.id}/subscriptions", params: {customer_id: customer1.id, tea_id: tea1.id}
      expect(response).to_not be_successful
      expect(response.status).to eq 404
      data = JSON.parse(response.body, symbolize_names: true)
      expect(data).to eq({:error=>"Subscription not created"})
    end
  end
end