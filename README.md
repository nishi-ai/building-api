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
1. add api/v1/restaurants in routes
2. create a controller for this request
  - instanciate an instance variable restaurants
  - policy_scope (thanks to Pundit)
  - So need to handle ActiveRecord request inside Restaurant_policy.rb (add scope.all)
3. generate JSON for the view (index.json.jbuilder)
* Jbuilder is a Gem, which is now a part of rails (Jbuilder Documantation: https://stedolan.github.io/jq/download/)
4. Test the controller works through POSTMAN
