Rails app generated with [lewagon/rails-templates](https://github.com/lewagon/rails-templates), created by the [Le Wagon coding bootcamp](https://www.lewagon.com) team.

## The purposes of building API
- For Mobile App Developers, to give only necessary resources as JSON
- For Customer, to provide just informations built in JSON form

## How to build API
1. Send HTTP request
2. raise the application
3. and get JSON back (HTTP response)

### API Endpoints
calling api is a HTTP request, which include header / body
(GET, POST, PATCH, DELETE)

POSTMAN (https://web.postman.co/) makes it easier to send HTTP request 

### Authentication (Devise)
is needed, because no one wants every visitor to access all data and edit them

### Authorization (Pundit)
is needed, because there should be some limitation even for the signed_in users

### API Controllers 
- live inside `app/contoller/api/v1`
- have a Base-Controller, act as parent of all api-controllers

### Base Controller
- include Pundit, to protect all api controllers
- verify_authorized
- verify_policy_scoped
- mathod `rescure_from` from classical errors
- definition telling to render all error messages as JSON, not as HTML file

## 1st Endpoint (#Index)
1. add [:index] api/v1/restaurants in routes, which is called `namespace`
2. create a controller for this request
  - instanciate an instance variable restaurants
  - policy_scope (thanks to Pundit)
  - So need to handle ActiveRecord request inside Restaurant_policy.rb (add scope.all)
3. generate JSON for the view (index.json.jbuilder)
* Jbuilder is a Gem, which is now a kind of ruby (Jbuilder Documantation: https://stedolan.github.io/jq/download/)
4. Test the controller works through POSTMAN (http://localhost:3000/api/v1/restaurants)

## 2nd Endpoint (#Show)
a more specific informations of a restaurant
1. 1. add [:show], api/v1/restaurants in routes, which is called `namespace`
2. add show in the controller for this request
  - fetch the specific restaurant by id
  - authorize it to make sure that signed user can access the info
  - To authorize it, add ```def show? true end``` in restaurant_policy (true == public to everyone!)
  - So need to handle ActiveRecord request inside Restaurant_policy.rb (add scope.all)
3. generate JSON for the view (show.json.jbuilder)
4. Test the controller works through POSTMAN (http://localhost:3000/api/v1/restaurants/1)

## 3rd Endpoint (#Update)
To edit specific informations of a restaurant, must make sure that people who send this request (= call api request) are authorized. They should be in the admin, or be the owner of the application, who created the restaurant.

In the browser, there is a session stored in a cookies, keeps current users
But for an api, there is no cookies. So we need a token.

1. add Gem `'simple_token_authentication'`
2. migrate AddTokenToUsers "authentication_token:string{30}:uniq"
3. add `acts_as_token_authenticatable` in User model
 ---> Now every time a new user is created && saved, an authentication_token is generated to each user.
5. add [:update], api/v1/restaurants in routes, which is called `namespace`
6. add show in the controller for this request
  - fetch the specific restaurant by id
  - authorize it to make sure that signed user can access the info
  - To authorize it, add ```def update? true end``` in restaurant_policy (true == public to everyone!)
  - `update? record.user == user ` 
  
       record: the restaurant passed to the `authorize` method in controller
       
       user:   the `current_user` signed in with Devise.
       
7. just render :show, no need to create a new json.update file.
8. Test the controller works through POSTMAN (http://localhost:3000/api/v1/restaurants/1)

send a HTTP request, which is will be aPATCh, with a right headers of authentication and json body to edit the data. 
** No need UI **

 acts_as_token_authentication_handler_for User, only: [ :update ]
 this gem extract the informations from headers and authenticate the user
