# Modules
A class can mix in a module with `include`, followed by the name of the module. (`include` is an instance method of the module `Module`.) Unlike inheriting from a class, a class can mix in an unlimited number of modules. 

Modules are very similar to classes with one major difference: Objects can only be created from classes, not modules. Otherwise, modules can contain constants, class methods/variables, instance methods/variables, and so on just like classes.

A class has a "has-a" relationship with its modules. The typical use case of a module is when there are behaviours specific to a subclass which do not fit well with other subclasses. Put differently, it groups common behaviours that do not fit a strict class hierarchy. Here, it is much more appropriate to mix in a module of these behaviours inside the compatible subclass than including them in the superclass. Therefore, module mix-ins are also thought as interface inheritance.

```ruby
module MyModule
  CONSTANT1 = "I'm a constant in MyModule"
  @@class_var1 = "I'm a class variable in MyModule"

  attr_accessor :ivar1

  def set_ivar1(input)
    self.ivar1 = input
  end

  def do_something
    puts "I'm from an instance method in MyModule and I'm doing a thing."
  end

  def self.do_something
    puts "I'm from a class method in MyModule and I'm doing a thing."
  end

  def output_constant
    puts CONSTANT1
  end

  def output_class_var
    puts @@class_var1
  end
end

class MyClass
  include MyModule
end

obj1 = MyClass.new
obj1.do_something     # Output: I'm from an instance method in MyModule and I'm doing a thing.
MyModule.do_something # Output: I'm from a class method in MyModule and I'm doing a thing.
obj1.output_constant  # Output: I'm a constant in MyModule
obj1.output_class_var # Output: I'm a class variable in MyModule
```

# Additional Use Case: Namespace
Modules can be used as containers to group classes and modules. This prevents name collisions and helps with code organization.

```ruby
module Namespace1
  module MyModule
    def do_something
      puts "I'm: #{self}!"
    end
  end

  class MyClass1
    include MyModule
  end

  class MyClass2
    include MyModule
  end
end

Namespace1::MyClass1.new.do_something # Output: I'm: #<Namespace1::MyClass1:0x0000000106eb21c8>!
Namespace1::MyClass2.new.do_something # Output: I'm: #<Namespace1::MyClass2:0x0000000106eb1fc0>!
```

# Additional Use Case: Module Methods
Modules are also used to house utility methods that otherwise do not fit well in any class. Similar to class methods, module method names need to be prefixed with `self` in the signature.

```ruby
module Conversions
  def self.fahrenheit_to_celsius(n)
    (n - 32) * 5 / 9
  end
end

puts Conversions.fahrenheit_to_celsius(32) # Output: 0
```
