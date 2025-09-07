# Fake Operators
Most Ruby operators are in fact methods, with many being grouped in modules like `Comparable` and `Enumerable`. This fact allows us to create and customize operators that work with objects of custom classes using inheritance. In fact, built-in classes themselves typically have specific implementations of these methods/operators for them to work with the type of data associated with the built-in class.

```ruby
class Wallet
  include Comparable

  attr_reader :balance

  def initialize(balance)
    @balance = balance
  end

  def <=>(other)
    if balance < other.balance
      -1
    elsif balance > other.balance
      1
    elsif balance == other.balance
      0
    end
  end
end

wallet1 = Wallet.new(100)
wallet2 = Wallet.new(50)

p wallet1 > wallet2 # => true
p wallet1 < wallet2 # => false
```

In the code example above, the custom class Wallet does not inherently come with comparison operators (like `<`, `>`, `==`, etc.). To enable the comparison of two different wallet objects (more specifically, their balances), `Comparable` is mixed in to `Wallet`. `Comparable` now supplies `Wallet` with all of its comparison operators; but because their balances are what are actually being compared when two `Wallet` objects are in comparison, `<=>` needs to be overriden to enable the operators to work properly.

# Equality
**(I honestly do not remember much about this topic. I will just jot down what I do know vaguely.)**

When examined closely, it is not straightforward what establishes equality when comparing two objects. Often, we are not comparing whether the two objects are the same object in the memory (though that can be done). Instead, we are comparing some other aspects (i.e., some part of their states) of them.

In Ruby, there are different ways to evaluate the different kinds of equality between objects. **(I wonder if this is true. I think it is true, but I forgot what are the specific ways of doing so.)**