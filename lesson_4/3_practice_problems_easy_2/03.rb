module Taste
  def flavor(flavor)
    puts "#{flavor}"
  end
end

class Orange
  include Taste
end

class HotSauce
  include Taste
end

=begin
Q: How do you find where Ruby will look for a method when that method is
   called?

A: When Ruby is trying to resolve a method, it searches for that method in its
   method lookup path. The path always begins with the receiver's class.
   Calling ancestors on the class of the object returns the method lookup path.

Q: How can you find an object's ancestors?

A: I can call Class::ancestors on the class of the object. This returns the
   list of ancestors of the object's class in the form of an array. The array
   contains the ancestor classes and modules, ordered from the first class in
   which the target method is looked for to last.

Q: What is the lookup chain for Orange and HotSauce?
=end

p Orange.ancestors # => [Orange, Taste, Object, Kernel, BasicObject]

p HotSauce.ancestors # => [HotSauce, Taste, Object, Kernel, BasicObject]

p Orange.class.ancestors # => [Class, Module, Object, Kernel, BasicObject]

=begin
NOTES

When ancestors is called on a custom class, the ancestors that gets called is
actually Module#ancestors. It may come as a surprise, but Module#ancestors is
an instance method. Despite it being an instance method, Module#ancestors can
be called like a class method on a custom class because any custom class is an
object of the class Class, and Class is a subclass of Module. Therefore, when
ancestors is called on a custom class, Ruby looks up ancestors in the lookup
path of Class and finds ancestors in Module and executes it.
=end
