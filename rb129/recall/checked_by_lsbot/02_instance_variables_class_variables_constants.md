# Instance Variables
Instance variables store the state of an object. A class contains so-called attribute specifiers that predetermine its objects' instance variables. This is necessary because instance variables technically do not exist in the class, even though attribute specifiers look like instance variables. They come into existence when some value is assigned to them, which only happens once the object they are associated with is created.

Instance variables have names that begin with `@`. They are scoped to the individual objects that they belong to. **(How does inheritance affect this scope?)**

```ruby
class MyClass
  def initialize(input1, input2)
    @ivar1 = input1
    @ivar2 = input2
  end
end
```

# Class Variables
Class variables store data associated with a class.

Class variables have names that begin with `@@`. They are scoped to the class, which means they are accessible anywhere throughout the class. **(How does inheritance affect this scope?)**

```ruby
class MyClass
  @@class_var1 = 'some value'
  @@class_var2 = 'some other value'
end
```

## Add-On from LSBot Review
There is only one copy of any class variable. This one copy is shared across the class and of its superclasses.

# Constants
Constants store data that are not supposed to be altered. Ruby does allow for alteration if necessary, but it will raise a warning.

Constants have names that begin with an uppercase letter, though the convention is to make all the letters of a constant's name uppercase. Constants have lexical scope, which means Ruby searches for a particular constant when it is called in the immeidate vicinity **(I'm not so sure if "vicinity" is the best term here)**; in the context of a typical class constant, the immediate vicinity would be the scope of the class. If the constant is not found, Ruby moves out of the class and tries to find it in the main frame. **(How does inheritance affect this scope?)**

```ruby
class MyClass
  CONSTANT1 = 'some value'
  CONSTANT2 = 'some other value'
end
```