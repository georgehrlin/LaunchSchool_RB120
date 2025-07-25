class Person
  attr_accessor :name, :age

  def initialize(name, age)
    @name = name
    @age = age
  end

  def >(other_person)      # Without this instance method, line 17 and 18 would
    age > other_person.age # raise a NoMethodError because > is not defined for
  end                      # Person
end

bob = Person.new('Bob', 49)
kim = Person.new('Kim', 33)

puts 'bob is older than kim' if bob > kim  # >> bob is older than kim
puts 'bob is older than kim' if bob.>(kim) # >> bob is older than kim
