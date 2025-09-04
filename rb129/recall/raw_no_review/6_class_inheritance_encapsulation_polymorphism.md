# Class Inheritance
In Ruby, a subclass can inherit from a mxiamum of one superclass. Once inheritance is established, the subclass gains access to all of its superclass's (and the superclass's superclasses') constants, variables, methods, attribute specifiers, and mix-ins.

A superclass has an "is-a" relationship with its subclasses, which means conceptually a subclass is a sub-type of its superclass (which also makes intuitive sense since a class is a type of "things").

To establish an inheritance, use `<` between the names of the subclass and its superclass in the signature of the subclass.

```ruby
class MySuperclass
  CONSTANT1 = 12211995
  @@class_var1 = 42

  def initialize(input)
    @ivar1 = input
  end

  def self.print_constant
    puts "I'm from a class method. The class constant is: #{CONSTANT1}"
  end

  def self.print_class_var
    puts "I'm also from a class method. The class variable is: #{@@class_var1.object_id}"
  end

  def do_something
    puts "I'm from an instance method."
  end
end

class MySubclass < MySuperclass; end

subclass_obj = MySubclass.new('some value')
p subclass_obj              # => #<Subclass:0x00000001054a1e50 @ivar1="some value">
subclass_obj.do_something   # Output: I'm from an instance method.
MySubclass.print_constant   # Output: I'm from a class method. The class constant is: 12211995
MySubclass.print_class_var  # Output: I'm also from a class method. The class variable is: 42
```

# Encapsulation
At its core, encapsulation in Ruby is about packaging data into independent entities called objects with behaviours that can be customized. There are advantages to this. First, implementation details can be abstracted away which allows users to focus on the interface of an object. Second, boundaries can be established to prevent data from being accessed or modified. Third, because objects are independent and most things in Ruby can be said to be objects, programs can be built with parts that do not immediate depend on each other. This allows for better mantainability.

# Polymorphism
Polymorphism refers to a feature of Ruby where data of different types are able to respond to the same interface (or the same methods). In Ruby, so long as a type of data contains the method, data of that type can then respond to the method.

In Ruby, polymorphism is achieved through inheritance, module mix-in, and duck typing.

```ruby
# Inheritance
class MySuperclass
  def do_something
    puts 'I did a thing!'
  end
end

class MySubclass < MySuperclass; end

obj1 = MySuperclass.new
obj2 = MySubclass.new

obj1.do_something   # Output: I did a thing!
obj2.do_something   # Output: I did a thing!
```

```ruby
# Module mix-in
module MyModule
  def do_something
    puts 'I did a thing!'
  end
end

class MyClass1
  include MyModule
end

class MyClass2
  include MyModule
end

obj1 = MyClass1.new
obj2 = MyClass2.new

obj1.do_something   # Output: I did a thing!
obj2.do_something   # Output: I did a thing!
```

```ruby
# Duck typing
class DuckClass
  def quack
    puts 'QUACK! QUACK! QUACK!'
  end
end

class MyClass
  def quack
    puts 'QUACK? QUACK? QUACK?'
  end
end

duck1 = DuckClass.new
obj1  = MyClass.new

duck1.quack # Output: QUACK! QUACK! QUACK!
obj1.quack  # Output: QUACK? QUACK? QUACK?
# Despite the different outputs, this code still illustrates an example of
# polymorphism because two objects of different classes (duck1 and obj1) can be
# called with the same method (quack).
```