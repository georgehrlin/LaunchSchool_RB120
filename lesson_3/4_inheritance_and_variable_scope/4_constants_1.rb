class Vehicle
  WHEELS = 4
end

WHEELS = 6

class Car < Vehicle
  def wheels
    WHEELS
  end
end

car = Car.new
# puts car.wheels # => 4

# Ruby attempts to resolve the WHEELS constant on line 9 by searching the
# lexical scope up to (but not including) the main scope. Ruby then searches by
# inheritance where it finds the WHEELS constant in the Vehicle class, which is
# why 4 is output on line 14. The top level scope is only searched after Ruby
# tries the inheritance hierarchy.

# If we comment out the initialization of WHEELS on line 2, line 14 will return
# 6.

# ------------------------------------------------------------

# Q: If we want to access a constant defined in the class of the calling object
# rather than the lexically scoped class, how might we write our code to
# achieve that?

class ASuperClass
  SOMECONSTANT = 42
end

class ASubClass < ASuperClass
  SOMECONSTANT = 25

  def show_constant1
    SOMECONSTANT # Even though this accesses the constant initialized on line
  end            # 36, it's still done so via searching the lexical scope

  def show_constant2
    self.class::SOMECONSTANT # This specifies accessing the specific constant
  end                        # in the class of the receiver
end

obj1 = ASubClass.new
p obj1.show_constant1 # => 25
p obj1.show_constant2 # => 25

p obj1.show_constant1.object_id # => 51
p obj1.show_constant2.object_id # => 51
