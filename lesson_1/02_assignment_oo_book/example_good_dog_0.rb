class GoodDog
  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    @name = n
    @height = h
    @weight = w
  end

  def self.what_am_i
    puts "I'm a GoodDog class!"
  end

  def speak
    "#{@name} says ARF!"
  end

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end
end

GoodDog.what_am_i

# sparky = GoodDog.new('Sparky', '12 inches', '10 lbs')
# puts sparky.info # Output: Sparky weighs 10 lbs and is 12 inches tall.

# sparky.change_info('Spartacus', '24 inches', '45 lbs')
# puts sparky.info # Output: Spartacus weighs 45 lbs and is 24 inches tall.

# puts sparky.speak    # Output: Sparky says arf!
# puts sparky.name     # Output: Sparky
# sparky.name = "Spartacus"
# puts sparky.name # Output: Spartacus

# fido = GoodDog.new("Fido")
# puts fido.speak # Output: Fido says arf!
