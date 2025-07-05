=begin
You want to create a nice interface that allows you to accurately describe the
action you want your program to perform. Create a method called spray_paint 
that can be called on an object and will modify the color of the car.
=end

class MyCar
attr_accessor :colour
attr_reader :year

  def initialize(year, colour, model)
    @year = year
    @colour = colour
    @model = model
    @current_speed = "0 kmh"
    @on_off = 'on'
  end

  def spray_paint(colour)
    self.colour = colour
    puts "Yooo... The new #{colour} paint job is hella lit!"
  end

  def speed_up(kmh)
    @current_speed = "#{kmh.to_s} kmh"
  end

  def break
    @current_speed = "0 kmh"
  end

  def shut_off
    @on_off = 'off'
  end
end

car1 = MyCar.new(2025, 'silver', 'Tesla Cybertruck')
p car1.colour
car1.spray_paint('army')
p car1.colour
