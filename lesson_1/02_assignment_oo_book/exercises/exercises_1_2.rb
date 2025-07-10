=begin
Add an accessor method to your MyCar class to change and view the color of your
car. Then add an accessor method that allows you to view, but not modify, the
year of your car.
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

p car1 = MyCar.new(2025, 'white', 'Tesla Model Y')
p car1.colour
p car1.colour = 'red'
p car1.colour
p car1.year
