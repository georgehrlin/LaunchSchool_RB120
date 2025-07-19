class SomeClass
  def initialize(val)
    @a_val = val
  end

  def return_the_val
    a_val
  end

  def print_the_val
    puts a_val
  end

  private

  attr_reader :a_val
end

some_obj = SomeClass.new('hi I guess')
p some_obj.return_the_val
p some_obj.self.a_val
