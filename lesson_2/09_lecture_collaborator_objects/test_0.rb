class Person
  attr_accessor :name, :pets

  def initialize(name)
    @name = name
    @pets = []
  end

  def pet(pet)
    @pets << pet
  end
end

class Dog; end
class Cat; end

bob = Person.new('Bob')
puppy = Dog.new
kitty = Cat.new

bob.pet(puppy)
bob.pet(kitty)

p bob.pets # => 