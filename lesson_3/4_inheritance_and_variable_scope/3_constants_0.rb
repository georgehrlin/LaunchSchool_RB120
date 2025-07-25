# Ruby first attempts to resolve a constant by searching in the lexical scope
# of that reference. If this is unsuccessful, Ruby will then traverse up the
# inheritance hierarchy of the structure of that references the constant.

module FourWheeler
  WHEELS = 4
end

class Vehicle
  def maintenance
    "Changing #{WHEELS} tires."
  end
end

class Car < Vehicle
  include FourWheeler

  def wheels
    WHEELS
  end
end

car = Car.new
puts car.wheels # >> 4
puts car.maintenance # uninitialized constant Vehicle::WHEELS (NameError)
