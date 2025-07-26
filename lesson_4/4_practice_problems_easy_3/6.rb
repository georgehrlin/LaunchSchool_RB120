class Cat
  attr_accessor :type, :age

  def initialize(type)
    @type = type
    @age  = 0
  end

  def make_one_year_older
    self.age += 1
  end
end

cat_1 = Cat.new('ragdoll')
puts cat_1.age
cat_1.make_one_year_older
puts cat_1.age

=begin
NOTES

I asked Grok 4 how come line 10 can function properly as is, given that
self.age += 1 is syntactic sugar for self.age = self.age + 1 and self.age=
references the setter method, age=.

Grok 4:
1. The expression is parsed and expanded internally to something equivalent to
   self.age = (self.age + 1).
2. First, Ruby evaluates the right-hand side: self.age + 1.
3. Next, Ruby assigns the result to the left-hand side by calling the setter
   method age= on self, which updates @age to 1.
=end
