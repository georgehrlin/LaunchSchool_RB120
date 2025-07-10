class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parse_full_name(full_name)
  end

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full_name)
    parse_full_name(full_name)
  end

  private

  def parse_full_name(full_name)
    parts = full_name.split
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end
end

bob = Person.new("Robert Smith")
puts "The person's name is: #{bob}"
p bob
puts bob

=begin
My Answer: (SOME INCORRECTNESS)
to_s is called on bob implicitly, which returns the Person object with its
object ID and instance variables.

Line 26 will output something along the lines of:
The person's name is #<Person0x000000000, @first_name: "Robert", @last_name:
"Smith">
=end

# The actual output of line 26 is:
# The person's name is: #<Person:0x0000000102651b90>

# NOTE: Calling puts on a Person object does not output its instance variables
