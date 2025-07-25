class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    return if person.not_yet_18?
    members.push(person)
  end
end

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

cowboys = Team.new('Dallas Cowboys')
emmitt = Person.new('Emmitt Smith', 46)

cowboys << emmitt

p cowboys.members # => [#<Person:0x0000000104c61e48 @name="Emmitt Smith", @age=46>]
