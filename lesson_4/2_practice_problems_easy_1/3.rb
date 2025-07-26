=begin
In the last question we had a module called Speed which contained a go_fast
method. We included this module in the Car class as shown below.
=end

module Speed
  def go_fast
    puts "I am a #{self.class} and going super fast!"
  end
end

class Car
  include Speed
  def go_slow
    puts "I am safe and driving slow."
  end
end

=begin
When we called the go_fast method from an instance of the Car class (as shown
below) you might have noticed that the string printed when we go fast includes
the name of the type of vehicle we are using. How is this done?
=end

small_car = Car.new
small_car.go_fast # >> I am a Car and going super fast!

=begin
ANSWER

When go_fast is called on the Car object small_car, Speed#go_fast is executed.
The body of Speed#go_fast calls puts with a string that includes an
interpolation, self.class, as an argument. Here, self references the Car
object, and calling class on it returns its class, Car. Therefore, the string
printed includes the name of the type of vehicle we are using.
=end
