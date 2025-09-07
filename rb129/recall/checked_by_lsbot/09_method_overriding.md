# Method Overriding
Because of inheritance and how method lookup works in Ruby, we can override and customize a pre-existing method by creating a method that shares the same name. 

However, do be careful to not accidentally override important built-in methods. Because every custom class inherits from the `Object` class, one can end up overriding its methods (like `send`) if not careful.

A common method to override is `to_s`.

```ruby
class PCDIY
  def initialize(cpu, gpu)
    @cpu = cpu
    @gpu = gpu
  end

  def to_s
    "CPU: #{@cpu} | GPU: #{@gpu}"
  end
end

pc = PCDIY.new('AMD 9950X3D', 'Asus ROG Astral OC RTX 5090')
puts pc # Output: CPU: AMD 9950X3D | GPU: Asus ROG Astral OC RTX 5090

# Without DIY#to_s, the output would instead be: #<PCDIY:0x00000001051a2510>
```

## Add-On from LSBot Review
`to_s` is a common example for method overriding because it is implicitly called in invocations of `puts` and string interpolations. Therefore, `to_s` can be modified for us to customize the final output.

Be mindful that while `to_s` is implicitly called with `puts`, if the custom `to_s` does not return a string, the return value would be ignored and Ruby will continue up the method lookup path to find a version of `to_s` (usually `Object#to_s`) that does return a string.

### Using `super` to Extend Functionality
It is possibly to only partially override a method with the `super` method. When `super` is invoked as a part of a method, Ruby looks for the next method with the same name in the lookup path and invokes it. Therefore, we can extend the functionality of a method using `super`.

```ruby
class PersonalComputer
  def initialize(brand)
    @brand = brand
  end
end

class Macintosh < PersonalComputer
  def initialize(model)
    super('Apple')
    @model = model
  end
end

mac1 = Macintosh.new('MacBook Air')
p mac1
```

The code above is a subtle example of overriding. Here, Macintosh is a subclass of `PersonalComputer`, and new on line 14 calls initialize. `Macintosh#initialize` is found first in the method lookup path and invoked over `PersonalComputer#initialize`. Therefore, we can say that `Macintosh#initialize`
overrides `PersonalComputer#initialize`.

We can also say that, by including super on line 9, the functionality of initialize is expanded. Whereas `PersonalComputer#initialize` only creates a instance variable, `@brand`, `Macintosh#initialize` creates an additional instance variable, `@model`.

To pass on all of the arguments to the method in a superclass with `super`, simply use `super` without specifying any argument. To invoke the method in a superclass without passing any argument (especially if the parent method takes no arguments), specify it with `super()`.