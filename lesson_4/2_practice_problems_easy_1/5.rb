=begin
Which of these two classes would create objects that would have an instance
variable and how do you know?
=end

class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

=begin
ANSWER

Pizza is the class that will create objects with an instance variable. Within
Pizza#initialize, an instance variable, @name, is initialized to the value of
name. Pizza#initialize is the constructor for the Pizza class. Therefore, every
Pizza object will contain a @name instance variable.
=end

# OFFICIAL SOLUTION

# We can check by doing the following:

a_cheese_pizza = Pizza.new('cheese')
a_star_fruit = Fruit.new('star fruit')

p a_cheese_pizza.instance_variables # => [:@name]
p a_star_fruit.instance_variables   # => []
