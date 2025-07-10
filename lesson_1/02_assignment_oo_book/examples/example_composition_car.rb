class Engine
  def start
    puts "Engine starting..."
  end
end

class Car
  def initialize
    @engine = Engine.new
  end

  def start
    @engine.start
  end
end

my_car = Car.new
my_car.start