module Swimmable
  def swim
    "I can swim!"
  end
end

class Animal; end

class Fish < Animal
  include Swimmable
end

class Mammal < Animal; end

class Cat < Animal; end

class Dog < Animal
  include Swimmable
end

sparky = Dog.new
neemo  = Fish.new
paws   = Cat.new

puts sparky.swim
puts neemo.swim
puts paws.swim
