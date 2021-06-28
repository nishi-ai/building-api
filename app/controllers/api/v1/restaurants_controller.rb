class Api::V1::RestaurantsController < Api::V1::BaseController
    before_action :set_restaurant, only: [ :show ]

    def index
      @restaurants = policy_scope(Restaurant) # and scope.all in restaurant policy
    # @restaurants = Restaurant.all (without Pundit)
    end

    def show
    end

    private

    def set_restaurant
        @restaurant = Restaurant.find(params[:id])
        authorize @restaurant # For Pundit
    end
  end