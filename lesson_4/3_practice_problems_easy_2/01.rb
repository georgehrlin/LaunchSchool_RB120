class Oracle
  def predict_the_future
    "You will " + choices.sample
  end

  def choices
    ["eat a nice lunch", "take a nap soon", "stay at work late"]
  end
end

oracle = Oracle.new
oracle.predict_the_future
# One of these is returned by line 12:
# "You wil eat a nice lunch"
# "You wil take a naps soon"
# "You wil stay at work late"
