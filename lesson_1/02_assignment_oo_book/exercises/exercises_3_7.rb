class Student
  attr_accessor :name

  def initialize(name, grade)
    self.name = name
    self.grade = grade
  end

  def better_grade_than?(student)
    grade > student.grade
  end

  protected

  attr_accessor :grade
end

joe = Student.new("Joe", 100)
bob = Student.new("Bob", 90)

puts "Well done!" if joe.better_grade_than?(bob)

# Official Solution
class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(other_student)
    grade > other_student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new("Joe", 90)
bob = Student.new("Bob", 84)
puts "Well done!" if joe.better_grade_than(bob)
