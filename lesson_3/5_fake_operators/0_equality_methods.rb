class Foo
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def ==(other)
    value == other.value
  end

  def !=(other)
    value == other.value
  end
end

foo1 = Foo.new(1)
foo2 = Foo.new(2)

p foo1 == foo2 # => false
p foo1 != foo2 # => false
p foo2 == foo2 # => true
p foo2 != foo2 # => true

# Because == and != are fake operators (they are actually methods), they can be
# overriden. Customizing == is esepcially useful when working with custom
# classes sometimes. However, this flexibility of Ruby can also lead to strange
# results like above.
