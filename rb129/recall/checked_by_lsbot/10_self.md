# `self`
`self` references different things when positioned at different locations within a class.

`self` references the calling instance/object when inside the definition of an instance method.

```ruby
class MyClass
  def display_self_in_instance_method
    puts "self is: #{self}"
  end
end

MyClass.new.display_self_in_instance_method
# Output: self is #<MyClass:0x0000000103032678>
```

Otherwise, when positioned outside of the definition of an instance method, `self` references the class.
