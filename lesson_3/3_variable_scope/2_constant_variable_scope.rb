# Constant variables are usually just called constants, because we are not
# supposed to reassign them to a different value
# Constants have lexical scope: Where the constant is defined in the source
# code determines where it is available. When Ruby tries to resolve a constant,
# it searches lexically; that is, it searches the surrounding structure of the
# constant reference

class Person1
  GREETINGS = ['Hello', 'Hi', 'Hey']

  def self.greetings
    GREETINGS.join(', ') # When Ruby executes GREETINGS here, it searches the
  end                    # surrounding sourcode

  def greet
    GREETINGS.sample # When Ruby executes GREETINGS here, it searches the
  end                # surrounding sourcode
end

puts Person1.greetings # >> Hello, Hi, Hey
puts Person1.new.greet # >> Hey

# --------------------------------------------------

module ElizabethanEra
  GREETINGS = ['How dost thou', 'Bless thee', 'Good morrow']

  class Person2
    def self.greetings
      GREETINGS.join(', ')
    end

    def greet
      GREETINGS.sample
    end
  end
end

puts ElizabethanEra::Person2.greetings # >> How dost thou, Bless thee, Good morrow
puts ElizabethanEra::Person2.new.greet # >> How dost thou

# --------------------------------------------------

class Computer
  GREETINGS = ["Beep", "Boop"]
end

class Person3
  def self.greetings
    GREETINGS.join(', ')
  end

  def greet
    GREETINGS.sample
  end
end

puts Person3.greetings # 50:in `greetings': uninitialized constant Person3::GREETINGS (NameError)
puts Person3.new.greet # 54:in `greet': uninitialized constant Person3::GREETINGS (NameError)

class Person4
  def self.greetings
    Computer::GREETINGS.join(', ') # :: is the namespace resolution operator
  end

  def greet
    Computer::GREETINGS.sample
  end
end

puts Person4.greetings # >> Beep, Boop
puts Person4.new.greet # >> Boop
