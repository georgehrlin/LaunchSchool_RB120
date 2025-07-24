class Person
  attr_accessor :name
end

bob = Person.new
bob.name = 'bob'

bob2 = Person.new
bob2.name = 'bob'

bob == bob2     # => false

bob_copy = bob
bob == bob_copy # => true
