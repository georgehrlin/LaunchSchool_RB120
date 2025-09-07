# Method Access Control
Method access control allows us to decide which instance methods can be invoked outside of the class, which can only be invoked from within the class, as well as which can be invoked externally but only by another instance of the same class.

Method access control in Ruby is carried out with `public`, `private`, and `protected` in a class. Public/private/protected instance methods are instance methods that follow `public`, `private`, or `protected` respectively. Public methods can be invoked externally. Private methods can only be invoked from inside their class. ~~Protected methods can be invoked externally~~ but only on objects of the same class.

This may be surprising, but `public`, `private`, and `protected` are method calls. They are instance methods of the `Module` class.

## Add-On from LSBot Review
Public methods form the class's interface. Unless specified, instance methods are public by default.

The key rule with private methods is they cannot be called with an explicit receiver.

Protected methods, like private methods, cannot be invoked from outside of the class. The key difference between them is that protected methods allow access between instances of the same class. Therefore, protected methods can be called with an explicit receiver, so long as the receiver object is an instance of the same class or a subclass.