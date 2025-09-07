# Instance Methods
Instance methods must be invoked on individual instances of a class. Instance methods are defined like regular methods inside a class.

## Add-On from LSBot Review
Instance methods are chosen over class methods when a method needs to work with an object's specific state. (An instance method without access to instance variables often don't make much sense.)

```ruby
class MyClass
  def initialize(input1)
    @ivar1 = input1
  end

  def do_something # An instance method
    puts "I'm an object and I did a thing."
  end
end

obj1 = MyClass.new('some value')
obj1.do_something # Output: I'm an object and I did a thing.
```

# Class Methods
Class methods must be invoked on classes. Unlike instance methods, the signature of a class method must include `self` to differentiate it from an instance method. (This works because `self` refers to the class when it's part of the method signature.)

```ruby
class MyClass
  def initialize(input1)
    @ivar1 = input1
  end

  def self.do_something # A class method
    puts "I'm a class and I did a thing."
  end
end

MyClass.do_something # Output: I'm a class and I did a thing.
```