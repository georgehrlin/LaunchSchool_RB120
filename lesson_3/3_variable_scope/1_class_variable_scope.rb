# Class variables are scoped at the class level
# 1. All objects share one copy of the class variable. This implies objects can
#    access class variables by way of instance methods
# 2. Class methods can access a class variable provided the class variable has
#    been initialized prior to calling the method

class Person
  @@total_people = 0

  def self.total_people
    @@total_people
  end

  def initialize
    @@total_people += 1
  end

  def total_people
    @@total_people
  end
end

Person.total_people # => 0
Person.new
Person.new
Person.total_people # => 2

bob = Person.new
bob.total_people    # => 3

joe = Person.new
joe.total_people    # => 4

Person.total_people # => 4
