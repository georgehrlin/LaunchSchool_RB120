my_arr = %w(first second third fourth)

# element reference
my_arr[2]    # => "third"
my_arr.[](2) # => "third"

# element assignment
my_arr[4] = 'fifth'
puts my_arr.inspect # => ["first", "second", "third", "fourth", "fifth"]

my_arr.[]=(5, 'sixth')
puts my_arr.inspect # => ["first", "second", "third", "fourth", "fifth", "sixth"]

class Team
  attr_accessor :name, :members

  def initialize(name)
    @name = name
    @members = []
  end

  def <<(person)
    members.push(person)
  end

  def +(other_team)
    temp_team = Team.new('Temporary Team')
    temp_team.members = members + other_team.members
    temp_team
  end

  def [](idx)
    members[idx]
  end

  def []=(idx, obj)
    members[idx] = obj
  end
end

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

cowboys = Team.new('Dallas Cowboys')
cowboys << Person.new('Troy Aikman', 48)
cowboys << Person.new('Emmitt Smith', 46)
cowboys << Person.new('Michael Irvin', 49)

p cowboys.members

p cowboys[1]
cowboys[3] = Person.new('JJ', 72)
p cowboys[3]

p cowboys.members
