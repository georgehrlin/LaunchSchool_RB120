class WheeledVehicle
  attr_accessor :speed, :heading

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    @fuel_efficiency = km_traveled_per_liter
    @fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Catamaran < WheeledVehicle
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    super(Array.new, km_traveled_per_liter, liters_of_fuel_capacity)
    @propeller_count = num_propellers
    @hull_count = num_hulls
  end
end

# Catamarans don't have tires. But we still want common code to track fuel
# efficiency and range. Modify the class definitions and move code into a
# Module, as necessary, to share code among the Catamaran and the wheeled
# vehicles.

=begin
CORRECTION/NOTES
I misunderstood the hints given in the question. The end of the question states
that "This new class does not fit well with the object hierarchy defined so
far. Catamarans don't have tires." Having read this, I should have not edited
Catamaran to inherit from WheeledVehicle. Instead, I should have created a
module that contains the methods shared across the classes.
=end
