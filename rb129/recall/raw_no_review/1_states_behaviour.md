# States
In OOP, states typically refer to the data associated with objects. An object's state is tracked by the object's instance variables. A class contains attributes, which are laid out as attribute specifiers that predetermine the instance variables of an object. The instance variables will in turn store the object's state when created (once some value is assigned to them).

```ruby
class MyClass
  def initialize(input1, input2)
    @attribute1 = input1
    @attribute2 = input2
  end
end

obj1 = MyClass.new('some data', 'some more data')
p obj1 # => #<MyClass:0x0000000107002550 @attribute1="some data", @attribute2="some more data">
```

# Behaviour
In OOP, behaviour typically refers to what an instance/object of a class can do. A class lays out the behaviour of its objects by defining instance methods. An object can then be the receiver of such instance methods and carry out actions ultimately defined by the programmer. From a different perspective, the interface of a class in the set of behaviours of the class.

```ruby
class MyClass
  def initialize(input1, input2)
    # Omitted code
  end

  def do_something
    puts 'I do a thing.'
  end
end

obj1 = MyClass.new('some data', 'some more data')
obj1.do_something # Output: I do a thing.
```
