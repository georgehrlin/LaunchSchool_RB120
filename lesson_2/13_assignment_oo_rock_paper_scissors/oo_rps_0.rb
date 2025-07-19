=begin
Player
  - choose
Move
Rule

  - compare
=end

class Player
  def initialize
    # Maybe a "name"? What about a "move"?
  end
end

class Move
  def initialize
    # Seems like we need something to keep track of the choice
    # A move object can be "paper", "rock", or "scissors"
  end
end

class Rule
  def initialize
    # Not sure what the "state" of a rule object should be
  end
end

# Not sure where "compare" goes yet
def compare(move1, move2)

end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Player.new
    @computer = Player.new
  end

  def play
    display_welcome_message
    human.choose
    computer.choose
    display_winner
    display_good_bye_message
  end
end

RPSGame.new.play
