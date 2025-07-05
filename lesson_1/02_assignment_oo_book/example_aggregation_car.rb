class Passenger
end

class Car
  def initialize(passengers)
    @passengers = passengers
  end
end

# Passengers can exist without Car
passengers = [Passenger.new, Passenger.new]
my_car = Car.new(passengers)
