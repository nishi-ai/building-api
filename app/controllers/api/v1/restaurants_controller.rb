class Api::V1::RestaurantsController < Api::V1::BaseController
    def index
      @restaurants = policy_scope(Restaurant) # and scope.all in restaurant policy
    # @restaurants = Restaurant.all (without Pundit)
    end
  end