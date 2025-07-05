=begin
1. Add a class method to your MyCar class that calculates the gas mileage (i.e.
   miles per gallon) of any car.

2. Override the to_s method to create a user friendly print out of your object.
=end

class MyCar
  attr_accessor :colour
  attr_reader :year, :model

  def initialize(year, colour, model)
    @year = year
    @colour = colour
    @model = model
    @current_speed = 0
  end

  def self.gas_mileage(miles_traveled, gallons_gas_used)
    "Mileage: #{miles_traveled.fdiv(gallons_gas_used)} MPG."
  end

  def to_s
    "The car is a #{year} #{model} in #{colour}."
  end

  def spray_paint(colour)
    self.colour = colour
    puts "Yooo... The new #{colour} paint job is hella lit!"
  end

  def speed_up(kmh)
    @current_speed += kmh
    puts "You sped up. The car is moving at: #{@current_speed} KM/h."
  end

  def brake(kmh)
    @current_speed -= 0
    puts "You slowed down. The car is moving at: #{@current_speed} KM/h."
  end

  def shut_off
    @current_speed = 0
    puts "The car is now parked."
  end
end

p MyCar.gas_mileage(351, 15)

car1 = MyCar.new(2024, "black", "Tesla Model Y")
puts car1