class Student
  attr_reader :id

  def initialize(name)
    @name = name
    @id
  end

  def id=(value)
    self.id = value
  end
end

tom = Student.new("Tom")
tom.id = 45

=begin
A: Line 15 raises a SystemStackError because the self.id = on line 10 is an
invocation of the id= setter method. This means that invoking id= on lin 15 is
repeatedly calling itself, overflowing the stack.
=end
