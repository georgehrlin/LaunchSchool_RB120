# Instance variables are scoped at the object level
class Person1
  def initialize(n)
    @name = n
  end

  def get_name  # Unlike local variables, instance variables are accessible
    @name       #  within an instance method even if they are not initialized
  end           #  or passed in to the method
end 

bob = Person1.new('bob')
joe = Person1.new('joe')

puts bob.inspect
puts joe.inspect

bob.get_name

# --------------------------------------------------

class Person2
  def get_name
    @name # @name here is never assigned to anything
  end
end

bill = Person2.new('bill')
bill.get_name # => nil # This is another key difference between instance
                       # variable and local variable. Calling an uninitialized
                       # local variable raises a NameError

# --------------------------------------------------

class Person3
  @name = 'bob' # Instance variables initialized at the class level are an
                # entirely different thing. These are class instance variables
  def get_name
    @name
  end
end

bard = Person3.new
bard.get_name # => nil