class Cat
  def initialize(type)
    @type = type
  end

  def to_s                # We can customize existing methods like this, but in
    "I am a #{@type} cat" # many cases it might be better to write a new method
  end                     # that is specific for an output
end

tabby = Cat.new('tabby')
puts tabby # >> I am a tabby cat
