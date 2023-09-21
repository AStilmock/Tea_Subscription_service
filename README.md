# Customer Tea Subscription Service - ReadME

## Initial Setup Steps

- Fork and Clone this repository in order to download and open
- Install all gems with command: bundle install
- Create the database and add seed data with command: rails db:{create,migrate,seed}
- Run the entire RSpec test suite with command: bundle exec rspec

## Database Schema Design

Three tables are in use for this application - Customers can create Subscriptions of different Teas. Subscriptions are created with a foreign key for both the customer and the tea in order to combine data from both tables in one place to be included in the subscription data. 

![Screen Shot 2023-09-21 at 5 05 59 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/74df5658-5ff5-444e-b03f-5fc80bbf775f)

## Application API EndPoint JSON Contract
### Create New Customer Subscription 
- Request Format: POST /api/v1/customers/:customer_id/subscriptions
- Send the request with specific params needed to create the Subscription: customer_id, tea_id, frequency, status (default status should be entered as 0)
- A successful response will generate a 201 status code for a succesful update to the Subscription and also a JSON response (shown below)
- A non-succesful response will generate a 404 error code for a non-succesful update to the Subscription along with a JSON response (shown below)

Succesful Response:

![Screen Shot 2023-09-21 at 5 26 17 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/ce2a2f93-5cb0-40dd-8a06-8b53cd0bdd17)

Non-Succesful Error Response:

![Screen Shot 2023-09-21 at 5 27 55 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/2ee515ce-21ea-4615-80f0-6005a0b502bb)

### Cancel Customer Subscription
- Request Format: PATCH /api/v1/customers/:customer_id/subscriptions/:subscription_id
- No specific params need to be sent with this request
- A successful response will generate a 201 status code for a succesful update to the Subscription and also a JSON response (shown below)
- A non-succesful response for a subscription that is already canceled will generate a 404 error code for a non-succesful update to the Subscription along with a JSON response (shown below)

Succesful Response:

![Screen Shot 2023-09-21 at 5 32 55 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/898530a9-efa9-4bc8-9448-e57e4554395a)

Non-Succesful Error Response:

![Screen Shot 2023-09-21 at 5 33 26 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/824e0089-9fb2-4481-be07-5fe444cbc4b0)

### View All Subscriptions for a Customer
- Request Format: GET /api/v1/customers/:customer_id/subscriptions
- No specific params need to be sent with this request
- A successful response will generate a 201 status code for a succesful update to the Subscription and also a JSON response (shown below)
- The JSON response in this endpoing includes the tea data as an attribute hash within the return of the subscription data in order to view which teas are included in their subscriptions
- A non-succesful response if a customer has no subscriptions (active or cancelled) will generate a 404 error code for a non-succesful update to the Subscription along with a JSON response (shown below)

Succesful Response:

![Screen Shot 2023-09-21 at 5 36 30 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/b32fd7d1-2acd-4c34-a413-1f1df570050f)

Non-Succesful Error Response:

![Screen Shot 2023-09-21 at 5 38 05 PM](https://github.com/AStilmock/Tea_Subscription_service/assets/125514479/8bb2a99c-91b8-4cdb-a0a2-254840b465bd)


