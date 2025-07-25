class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!" # @name can be referenced here
  end
end

p teddy = Dog.new('Teddy') # => #<Dog:0x0000000104af2468 @name="Teddy">
puts teddy.dog_name # >> bark! bark! Teddy bark! bark!

=begin
NOTES

Because Dog does not have an #initialize method, Ruby uses Dog's superclass,
Animal's, #initialize. On line 13, once 'Teddy' is passed to Animal#initialize,
the initialized @name is actually attached to the obect that teddy points to.
This can be seen in the return value of line 13.
=end
