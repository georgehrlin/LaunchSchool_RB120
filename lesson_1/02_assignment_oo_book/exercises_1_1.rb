=begin
Create a class called MyCar. When you initialize a new instance or object of
the class, allow the user to define some instance variables that tell us the
year, color, and model of the car. Create an instance variable that is set to 0
during instantiation of the object to track the current speed of the car as
well. Create instance methods that allow the car to speed up, brake, and shut
the car off.
=end

class MyCar
  def initialize(year, colour, model)
    @year = year
    @colour = colour
    @model = model
    @current_speed = 0
  end

  def speed_up(kmh)
    @current_speed += kmh
    puts "You push the gas pedal and accelerate #{kmh} kmh."
  end

  def brake(kmh)
    @current_speed -= kmh
    puts "You push the brake pedal and decedelerate #{kmh} kmh."
  end

  def shut_off
    @current_speed = 0
    puts "This bad boy is parked!"
  end
end

p car1 = MyCar.new(2025, 'black', 'Tesla Model S')
# => #<MyCar:0x00000001006c1a00 @year=2025, @colour="black", @model="Tesla Model S", @current_speed=0, @on_off="on">
car1.speed_up(120)
p car1
car1.brake(70)
p car1
car1.shut_off
p car1
