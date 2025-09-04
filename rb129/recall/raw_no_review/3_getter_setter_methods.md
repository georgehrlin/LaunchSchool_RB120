# Getter and Setter Methods
Getter methods are instance methods used for accessing instance variables.
Setter methods are instance methods used for assigning or reassigning instance variables.
Together, they are a key way to control access to data in Ruby. Without them, instance variables cannot be accessed or reassigned outside of a class.

Getter and setter methods can be created manually like any standard instance method in a class.

```ruby
class MyClass
  def initialize(input1, input2)
    @ivar1 = input1
  end

  def ivar1 # A getter method
    @ivar1
  end

  def ivar1=(new_val) # A setter method
    @ivar1 = new_val
  end
end
```

Alternatively, getter and setter methods can be created with attribute accessors: `attr_reader`, `attr_writer`, and `attr_accessor`. Attribute accessors are Ruby's way to efficiently create getter and setter methods because they are so common.

This may be surprising, but attribute accessors are method invocations. They are methods of the `Module` class. They accept symbols or strings (which are then converted into symbols) as names of the instance variabels and methods.

```ruby
class MyClass
  attr_reader :ivar1
  # This creates a getter method ivar1 and an attribute specifier for @ivar1
  attr_writer :ivar2
  # This creates a setter method ivar2= and an attribute specifier for @ivar2
  attr_accessor :ivar3
  # This creates a getter method ivar3, a setter method ivar3=, and an
  # attribute specifier for @ivar3
end
```

There is a caveat when invoking a setter method inside the deifnition of an instance method. The method must be preceded with `self` (e.g., `self.ivar3 = 'new value'`) to disambiguate it from instantiating a local variable (e.g., `ivar3 = 'new value'` would be interpreted as instantiating a new `ivar3` local variable).