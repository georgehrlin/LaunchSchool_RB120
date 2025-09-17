class Student
  def initialize(id, name)
    @id = id
    @name = name
  end

  def ==(other)
    self.id == other.id
  end

  private

  attr_reader :id, :name
end

rob = Student.new(123, "Rob")
tom = Student.new(456, "Tom")

rob == tom

=begin
A: Line 19 raises an error because the invocation of Student#== invokes the
private method id on rob and tom but this is outside of the class.
=end

=begin
Correction: The error raised is NoMethodError, and execution stops specifically
when id is invoked on tom.
=end
