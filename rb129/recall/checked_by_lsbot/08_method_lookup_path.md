# Method Lookup Path
When a method is invoked in Ruby, Ruby searches for the method in its method lookup path to determine which method is invoked. The search begins in the class of the receiver object, then, if the method is not found, the search moves on to the class's last mixed in module, other modules, the class's superclass, the superclass's modules, and so on and so forth.

The class method `ancestors` returns the method lookup path of a class.

```ruby
module ModuleInSuperclass; end

class MySuperclass
  include ModuleInSuperclass
end

module FirstMixedInModule; end

module LastMixedInModule; end

class MySubclass < MySuperclass
  include FirstMixedInModule
  include LastMixedInModule
end

p MySubclass.ancestors
# => [MySubclass, LastMixedInModule, FirstMixedInModule, MySuperClass,
#     ModuleInSuperclass, Object, Kernel, BasicObject]
```

"`BasicObject` is the parent class of all classes in Ruby. In particular, `BasicObject` is the parent class of class `Object`, which is itself the default parent class of every Ruby class."

"The `Kernel` module is included by class `Object`, so its methods are available in every Ruby object."