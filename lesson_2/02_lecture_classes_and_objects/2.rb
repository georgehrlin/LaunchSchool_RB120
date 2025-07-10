class Person
  attr_accessor :first_name, :last_name

  def initialize(n)
    @first_name = n
    @last_name = ''
  end

  def name
    @last_name == '' ? "#{@first_name}" : "#{@first_name} #{@last_name}"
  end
end

# Provided code
bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

# Official Solution
class Person
  attr_accessor :first_name, :last_name

  def initialize(full_name)
    parts = full_name.split
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  def name
    "#{first_name} #{last_name}".strip
  end
end
