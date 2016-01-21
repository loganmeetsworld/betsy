module ShippingService
  class Package

    def initialize(robot, orderitem, product)
      @robot_loc = get_robot_location(robot)
      @package_loc = get_package_location(orderitem)
      @dimensions = get_package_dimensions(product)
    end

    # return a JSON with correct formatting for the shipping service API
    def get_robot_location(robot)
    end

    def get_package_location(orderitem)
    end

    def get_package_dimensions(product)
    end

    # HTTParty request
    def get_fedex_rate
    end

    # HTTParty request
    def get_ups_rate
    end

  end
end
