class Light
  attr_accessor :brightness, :color

  def initialize(brightness, color)
    @brightness = brightness
    @color = color
  end

  def self.information
    return "I want to turn on the light with a brightness level of super high and a color of green"
  end

end

=begin
Q: What is used in this class but doesn't add any value?

A: (This is really awkward: I asked LSBot, the one integrated on the webpage,
what the question means by "doesn't add any value", and specifically what
"value" means here. It just straight-up told me that the answer here is the
return keyword because the code works the same without it.)
=end
