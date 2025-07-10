class Parent
  def say_hi
    p "Hi from Parent."
  end
end 

Parent.superclass # => Object

class Child < Parent
  def say_hi
    p "Hi from Child."
  end

  def send
    p "send from Child..."
  end

  def instance_of?
    p "I am a fake instance"
  end
end

lad = Child.new
lad.send :say_hi # Raises an ArgumentError error

c = Child.new
c.insance_of? Child   # => true
c.instance_of? Parent # => false

heir = Child.new
heir.instance_of? Child