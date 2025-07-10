class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(colour)
    super
    @colour = colour
  end
end

p bruno = GoodDog.new("brown")
