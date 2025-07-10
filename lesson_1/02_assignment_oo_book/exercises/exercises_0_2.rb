=begin
2. What is a module? What is its purpose? How do we use them with our classes?
   Create a module for the class you created in exercise 1 and include it
   properly.
=end

# A module can be thought of as a bundle of behaviours that can be mixed in to
# any class for that class to adopt the behaviours. A module can be mixed in to
# a class with the include method invocation.

module ExtractionMethods
  def espresso(coffee)
    puts "18 g in, 38 g out, 25 s: 2 shots of #{coffee}"
  end

  def pourover(coffee)
    puts "16 g dry, 256 g water, 3:30 extraction time: 1 pourover of #{coffee}"
  end
end

class ArabicaCoffee
  include ExtractionMethods
end

todays_cup_of_coffee = ArabicaCoffee.new

# espresso(todays_cup_of_coffee) # Not how espresso is called

todays_cup_of_coffee.pourover('PNG Gesha')

# OFFICIAL SOLUTION
# A module allows us to group resuable code into one place. It expands the
# functionality of classes.

# Modules are also used as a namespace:

module ProcessingMethods
  class Washed
  end

  class Natural
  end
end

p todays_PNG_Gesha = ProcessingMethods::Washed.new
