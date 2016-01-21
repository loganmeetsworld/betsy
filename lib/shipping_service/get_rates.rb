module ShippingService
  class Package

    BASE_URI = "https://botsy-shipping.herokuapp.com/"

    def initialize(robot, orderitem, product)
      @origin = get_robot_location(robot)
      @destination = get_package_location(orderitem)
      @package = get_package_dimensions(product)
    end

    # return a JSON with correct formatting for the shipping service API
    def get_robot_location(robot)
      return { "origin" => {"country" => robot.country, "state" => robot.state, "city" => robot.city, "postal_code" => robot.postal_code }}
    end

    def get_package_location(order)
      return  { "destination" => {"country" => "US", "state" => order.state, "city" => order.city, "postal_code" => order.zip }}
    end

    def get_package_dimensions(product)
      return { "package" => {"weight" => product.weight, "length" => product.length, "width" => product.width, "height" => product.height, "cylinder" => product.cylinder }}
    end

    # HTTParty request
    def get_fedex_rate
    end

    # HTTParty request
    def get_ups_rate
    end
  end
end
