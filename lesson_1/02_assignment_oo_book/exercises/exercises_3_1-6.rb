class Vehicle
  attr_accessor :colour
  attr_reader :year, :model
  @@num_total_vehicles = 0

  def self.display_num_total_vehicles
    puts "There are #{@@num_total_vehicles} vehicles currently."
  end

  def self.gas_mileage(miles_traveled, gallons_gas_used)
    "Mileage: #{miles_traveled.fdiv(gallons_gas_used)} MPG."
  end

  def initialize(year, colour, model)
    @year = year
    @colour = colour
    @model = model
    @current_speed = 0
    @@num_total_vehicles += 1
  end

  def display_current_speed
    puts "Current speed: #{@current_speed} KM/h"
  end

  def speed_up(kmh)
    @current_speed += kmh
    puts "You sped up. The car is now moving at: #{@current_speed} KM/h."
  end

  def brake(kmh)
    @current_speed -= kmh
    puts "You slowed down. The car is moving at: #{@current_speed} KM/h."
  end

  def shut_off
    @current_speed = 0
    puts "The car is now parked."
  end

  def spray_paint(colour)
    self.colour = colour
    puts "Yooo... The new #{colour} paint job is hella lit!"
  end

  def age
    puts "Your #{year} #{model} is #{current_year - year} years old."
  end

  private

  def current_year
    Time.now.year
  end
end

module Towable
  def can_tow_heavy?
    true
  end
end


class MyCar < Vehicle
  CLASSIFICATION = :noncommercial

  def to_s
    "My car is a #{year} #{model} in #{colour}."
  end
end

class MyTruck < Vehicle
  include Towable

  CLASSIFICATION = :commercial

  def to_s
    "My truck is a #{year} #{model} in #{colour}."
  end
end

=begin
puts car1 = MyCar.new(2024, 'black', 'Tesla Model S')
puts truck1 = MyTruck.new(1992, 'blue', 'Peterbilt 379')

Vehicle.display_num_total_vehicles

p truck1.can_tow_heavy?

p MyCar.ancestors
p MyTruck.ancestors
p Vehicle.ancestors
=end

=begin
puts car1 = MyCar.new(2024, 'black', 'Tesla Model S')
puts truck1 = MyTruck.new(1992, 'blue', 'Peterbilt 379')

car1.speed_up(100)
car1.display_current_speed
car1.brake(50)
car1.display_current_speed
puts
truck1.spray_paint('Optimus Prime')
puts truck1
=end

truck1 = MyTruck.new(1992, 'blue', 'Peterbilt 379')
truck1.age

car1 = MyCar.new(2024, 'black', 'Tesla Model S')
car1.age
