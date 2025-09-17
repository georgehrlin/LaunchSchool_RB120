class Dog
  attr_accessor :name

  def good
    self.name + " is a good dog"
  end
end

bandit = Dog.new
bandit.name = "Bandit"
p bandit.good

=begin
A: The self on line 5 refers to the bandit object. self in an instance method
always refers to the individual object.
=end
