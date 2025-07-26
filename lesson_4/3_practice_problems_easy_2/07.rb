class Cat
  @@cats_count = 0

  def initialize(type)
    @type = type
    @age = 0
    @@cats_count += 1
  end

  def self.cats_count
    @@cats_count
  end
end

=begin
@@cats_count is a class variable which is initialized to 0 on line 2. It keeps
track of how many instances of Cat have been initialized because it is
incremented by 1 by the constructor, so it increases by 1 whenever a new
instance of Cat is initialized. A class method, cats_count is defined on line
10, so we can access the total number of Cat instances by calling cats_count on
the Cat class.
=end

cat1 = Cat.new('ragdoll')
cat2 = Cat.new('birman')
cat3 = Cat.new('sphynx')

p Cat.cats_count # => 3
