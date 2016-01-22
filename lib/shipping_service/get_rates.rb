module ShippingService
  class Order

    BASE_URI = "https://botsy-shipping.herokuapp.com/"

    def initialize(order)
      # @origin = get_robot_location(robot)
      @destination = get_package_location(order)
      # @package = get_package_dimensions(product)
      @orderitems = order.orderitems
    end

    # return a JSON with correct formatting for the shipping service API
    def get_robot_location(robot)
      return {"country" => robot.country, "state" => robot.state, "city" => robot.city, "postal_code" => robot.postal_code }
    end

    def get_package_location(order)
      return {"country" => "US", "state" => order.state, "city" => order.city, "postal_code" => order.zip }
    end

    def get_package_dimensions(product)
      return {"weight" => product.weight, "length" => product.length, "width" => product.width, "height" => product.height, "cylinder" => product.cylinder }
    end

    # HTTParty request
    def get_rates(origin, package, carrier)
      HTTParty.post("#{BASE_URI}#{carrier}_rates", :headers => { 'Content-Type' => 'application/json' }, :body => { "origin" => origin, "destination" => @destination,  "package" => package }.to_json)
    end

    def get_total(carrier)
      total_hash = Hash.new(0)
      @orderitems.each do |item|
        origin = get_robot_location(item.product.robot)
        package = get_package_dimensions(item.product)
        array = get_rates(origin, package, carrier)
        bad_product = check_for_error(array)
        if bad_product
          return item.product.name
        else
          hash = make_hash(array)
          hash.each do |key, val|
            total_hash[key] += val
          end
        end
      end
      return total_hash
    end

    def check_for_error(array)
      if array.parsed_response[0] == ["error"]
        return true
      end
    end

    def make_hash(array)
      hash = {}
      array.each do |arr|
        hash[arr[0]] = arr[1]
      end
      return hash
    end
  end
end
