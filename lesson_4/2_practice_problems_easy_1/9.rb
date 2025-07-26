=begin
If we have the class below, what would you need to call to create a new
instance of this class.
=end

class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

bag_1 = Bag.new('beige', 'crocodile leather')
p bag_1
puts bag_1

=begin
NOTES

Because Bag#initialize prescribes two parameters to be provided, Bag.new has to
be called with two arguments.
=end
