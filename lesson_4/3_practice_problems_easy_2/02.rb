class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

class RoadTrip < Oracle
  # def choices
  #   ["visit Vegas", "fly to Fiji", "romp in Rome"]
  # end
end

trip = RoadTrip.new
p trip.predict_the_future
# Line 18 returns one of the following randomly:
# "You will visit Vegas"
# "You will fly to Fiji"
# "You will romp in Rome"

# Line 18 calls Oracle#predict_the_future on line 2, which then returns a
# concatenated string of "You will " and the string returned by choices.sample.
# Here, Ruby searches its method lookup path, starting from RoadTrip, because
# the original receiver that started this series of executions is trip, an
# instance of RoadTrip. Ruby finds a choices in RoadTrip, which returns an
# array of strings, and calls sample on this array, returning one of its
# strings.

=begin
NOTES

From Official Solution: Doesn't the choices called in the implementation of
Oracle's predict_the_future look in the Oracle class for a choices method? The
answer is that since we're calling predict_the_future on an sintance of
RoadTrip, every time Ruby tries to resolve a method name, it will start with
the methods defined on the class you are calling. So even though the call to
choices happens in a method defined in Oracle, Ruby will first look for a
definition of choices in RoadTrip before falling back to Oracle if it does not
find choices defined in RoadTrip.
=end
