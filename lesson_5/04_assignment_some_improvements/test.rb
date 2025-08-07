Pet = Struct.new('Pet', :kind, :name, :age)
pet_1 = Pet.new('dog', 'Asta', 10)
pet_2 = Pet.new('cat', 'Cocoa', 2)
p pet_1.age # => 10

pet_2.age = 3
p pet_2.age # => 3

class Pet
  attr_accessor :kind, :name, :age

  def initialize(kind, name, age)
    @kind = kind
    @name = name
    @age = age
  end
end