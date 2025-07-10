class Animal
  def initialize
    puts "I'm in Animal."
  end
end

class Bear < Animal
  def initialize(colour)
    super()
    @colour = colour
  end
end

bear = Bear.new("black")
# => #<Bear:0x007fb40b1e6718 @colour="black">