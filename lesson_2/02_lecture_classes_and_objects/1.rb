class Person
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

# Provided code
bob = Person.new('bob')
p bob.name                  # => 'bob'
bob.name = 'Robert'
p bob.name                  # => 'Robert'
