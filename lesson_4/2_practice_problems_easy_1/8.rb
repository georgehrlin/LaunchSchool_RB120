=begin
If we have a class such as the one below. In the name of the cats_count method
we have used self. What does self refer to in this context?
=end

class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age  = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

=begin
ANSWER

When we use self inside the method signature (or method definition header) of a
class method, the self refers to the class. The self of self.cats_count refers
to the class Cat.
=end
