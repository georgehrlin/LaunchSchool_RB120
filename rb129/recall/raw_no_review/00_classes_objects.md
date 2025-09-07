# Classes
Objects are at the centre of OOP. Classes are like blueprints of objects. A class typically defines the attributes and behaviours of its objects.

A class can be created with the `class` keyword, followed by the class name.

```ruby
class MyClass
  # Omitted code
end
```

Any class in Ruby is itself an object/instance of the `Class` class.

# Objects
It can be said that most things in Ruby are objects. Objects are at the centre of OOP because (in part) they allow for the custom categorization of data into classes, whose attributes and behaviours can be manually defined.

An object/instance of a class can be instantiated by invoking the `new` class method on the class.

```ruby
class MyClass; end

obj1 = MyClass.new
p obj1 # => #<MyClass:0x0000000100842898>
```
