class Game
  def play
    "Start the game!"
  end
end

class Bingo < Game
  def rules_of_play
    #rules of play
  end
end

=begin
Q: What would happen if we added a play method to the Bingo class, keeping in
mind that there is already a method of this name in the Game class that the
Bingo class inherits from.

A: Once we added a play instance method to Bingo, when we call play on a Bingo
object, Bingo#play will be called instead of Game#play. This is because
Bingo#play has overriden Game#play. When play is called on a Bingo object, Ruby
starts looking for a play method first from the class that the object belongs,
then proceeds up the method lookup path. Because a Bingo#play already exists,
it is immediately called.
=end
