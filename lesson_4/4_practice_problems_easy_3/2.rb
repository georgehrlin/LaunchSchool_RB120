class Greeting
  def greet(message)
    puts message
  end
end

class Hello < Greeting
  def hi
    greet("Hello")
  end

  def self.hi
    puts "Hello"
  end
end

class Goodbye < Greeting
  def bye
    greet("Goodbye")
  end
end

# Q: If we call Hello.hi we get an error message. How would you fix this?

# Either:
Hello.new.hi # >> Hello

# Or:
# Create a class method with def self.hi in the class Hello
Hello.hi # >> Hello
