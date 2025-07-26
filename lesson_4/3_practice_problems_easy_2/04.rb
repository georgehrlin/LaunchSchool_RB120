class BeesWax
  attr_accessor :type

  def initialize(type)
    @type = type
  end

  def describe_type
    puts "I am a #{type} of Bees Wax" # Use type instead of @type here
  end
end

# The standard practice is to refer to instance variables inside the class
# without @ if the getter method is available
