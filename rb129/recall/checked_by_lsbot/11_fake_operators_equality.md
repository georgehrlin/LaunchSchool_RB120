# Fake Operators
Most Ruby operators are in fact methods, with many being grouped in modules like `Comparable` and `Enumerable`. These are examples of Ruby's syntactic sugar, which allow for more natural code syntax. This fact also allows us to create and customize operators that work with objects of custom classes using inheritance. In fact, built-in classes themselves typically have specific implementations of these methods/operators for them to work with the type of data associated with the built-in class.

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

Do not assume that defining some operators manually generate their opposites automatically (e.g., defining a custom `<` does not give a custom `>`). However, Ruby does give you the `!=` method if a custom `==` is defined.

# Equality
When examined closely, it is not straightforward what establishes equality when comparing two objects. Often, we are not comparing whether the two objects are the same object in the memory (though that can be done). Instead, we are comparing some other aspects of them.

Ruby provides several different ways to check for equality, each with a specific purpose.

### `==` (Value Equality)
Mostly used to determine if two objects have the same value. By default, `==` behaves like `equal?`, so overriding it is necessary sometimes for meaningful value comparisons.

### `equal?` (Object Identity Equality)
Checks if two variables point to the same object in memory by comparing their object IDs. One should never override this method.

### `===` (Case Equality)
Mostly used by `case` statements to determine if an object "belongs" to a certain group or matches a pattern. Its meaning can vary significantly depending on the class. Generally there is no need to override it unless the objects of a class are intended to be used in `case` statements.

### `eql?` (Hash Key Equality)
A stricter version of `==`. It generally returns `true` only if the receiver and the argument have both the same value and are of the same type.
For instance, `1 == 1.0` returns `true`, but `1.eql?(1.0)` returns `false`.