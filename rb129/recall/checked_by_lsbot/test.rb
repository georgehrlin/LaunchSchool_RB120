class PersonalComputer
  def initialize(brand)
    @brand = brand
  end
end

class Macintosh < PersonalComputer
  def initialize(model)
    super('Apple')
    @model = model
  end
end

mac1 = Macintosh.new('MacBook Air')
p mac1

=begin
This is a subtle example of overriding. Here, Macintosh is a subclass of
PersonalComputer, and new on line 14 calls initialize. Macintosh#initialize is
found first in the method lookup path and invoked over
PersonalComputer#initialize. Therefore, we can say that Macintosh#initialize
overrides PersonalComputer#initialize.

We can also say that, by including super on line 9, the functionality of
initialize is expanded. Whereas PersonalComputer#initialize only creates
a instance variable, @brand, Macintosh#initialize creates an additional
instance variable, @model.
=end
