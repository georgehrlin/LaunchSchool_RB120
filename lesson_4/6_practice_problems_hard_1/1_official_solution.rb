module Moveable
  attr_accessor :speed, :heading
  attr_writer :fuel_capacity, :fuel_efficiency

  def range
    @fuel_capacity * @fuel_efficiency
  end
end

class WheeledVehicle
  include Moveable

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    @tires = tire_array
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end

  def tire_pressure(tire_index)
    @tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    @tires[tire_index] = pressure
  end
end

class Catamaran
  include Moveable

  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity

    # ... other code to track catamaran-specific data omitted ...
  end
end

# The Official Solution stops here, but I will include the other two modified 
# classes below

class Auto < WheeledVehicle
  # include Moveable # This is actually pointless because a subclass also
                     # inherits the instance methods of the module mixed in by
  def initialize     # the subclass's superclass
    super([30, 30, 32, 32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  # include Moveable # This is actually pointless because a subclass also
                     # inherits the instance methods of the module mixed in by
  def initialize     # the super class
    super([20, 20], 80, 8.0)
  end
end
