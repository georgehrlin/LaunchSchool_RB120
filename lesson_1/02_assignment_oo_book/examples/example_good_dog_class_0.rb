class Animal
  def speak
    "Hello!"
  end
end

class GoodDog < Animal
  attr_accessor :name

  def initialize(n)
    self.name = n
  end

  def speak
    "#{self.name} says arf!"
  end
end

class GoodCat < Animal
end

sparky = GoodDog.new("Sparky")
paws = GoodCat.new

puts sparky.speak
puts paws.speak
