class GoodDog
  @@genus = 'Canis'
  @@species = 'Canis lupus'
  @@subspecies = 'Canis lupus familiaris'

  attr_accessor :name, :height, :weight

  def initialize(n, h, w)
    self.name   = n
    self.height = h
    self.weight = w
  end

  def self.binomial_name # When self is prepended to a method
    "#{@@subspecies}"    # definition, it defines a class
  end                    # method

  def change_info(n, h, w)
    self.name   = n # self here refers to the calling obj
    self.height = h
    self.weight = w
  end

  def info
    "#{self.name} weighs #{self.weight} and is #{self.height} tall."
  end

  def what_is_self
    self
  end

  p self
end

sparky = GoodDog.new('Sparky', '12 in', '10 lb')
p sparky.what_is_self
# => #<GoodDog:0x00000001048716d0 @name="Sparky", @height="12 in", @weight="10 lb">
# Here, from within the class, when an instance method
# uses self, it references the calling object

p sparky.class.binomial_name # => "Canis lupus familiaris"
