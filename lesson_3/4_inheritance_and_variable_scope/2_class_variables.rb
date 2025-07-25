class Animal
  @@total_animals = 0

  def initialize
    @@total_animals += 1
  end
end

class Dog < Animal
  def total_animals
    @@total_animals
  end
end

spike = Dog.new
p spike.total_animals # => 1 # Class variables are accessible to subclasses

# ------------------------------------------------------------

class Vehicle
  @@wheels = 4

  def self.wheels
    @@wheels
  end
end

class Motorcycle < Vehicle
  @@wheels = 2
end

class Car < Vehicle; end

p Motorcycle.wheels # => 2
p Vehicle.wheels # => 2 # @@wheels is overwritten by line 32
p Car.wheels # => 2 @ @@wheels is overwritten for other subclasses too

# Because of this behaviour, avoid using class variables when working with
# inheritance. Some Rubyists would go as far as recommending avoiding class
# variables altogether. The solution here is usually using class instance
# variables.
