=begin
If we have a class such as the one below, you can see in the
make_one_year_older method we have used self. What does self refer to here?
=end

class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

=begin
ANSWER

The self inside the body of make_one_year_older refers to the object when
make_one_year_older is called on it. Any self within the body of an instance
method references the object.
=end
