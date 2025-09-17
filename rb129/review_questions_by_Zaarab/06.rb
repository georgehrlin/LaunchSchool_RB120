class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def greet
     "Hello! they call me #{name}"
  end
end

class Puppet < Person
  def initialize(name)
    super
  end

  def greet(message)
    puts super + message
  end
end

puppet = Puppet.new("Cookie Monster")
puppet.greet(" and I love cookies!")

=begin
A: This code will not execute, because line 24 invokes Puppet#greet with an
argument " and I love cookies!", which leads to super passing that string
argument to Person#greet, but Person#greet does not accept any argument.
=end
