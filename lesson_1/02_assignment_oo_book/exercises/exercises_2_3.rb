class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
puts bob.name
bob.name = "Bob"
puts bob.name

# This code raiese a NoMethodError because the class macro used only creates
# a getter method and not a setter method. Therefore, a setter method name= has
# not been created yet, and bob.name= is calling a methdod that does not
# exist. To fix it, change the attr_reader on line 2 to attr_accessor.
